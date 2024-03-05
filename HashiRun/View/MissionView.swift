//
//  SmallMapView.swift
//  RunningRPG
//
//  Created by Lorenzo Overa on 20/02/24.
//

import SwiftUI
import MapKit
import CoreLocation
import SwiftData

struct MissionView: View {
    
    @State var region = MKCoordinateRegion(
        center: .init(latitude: 31.334_900,longitude: -122.009_020),
        span: .init(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )
    
    var regionBinding: Binding<MKCoordinateRegion> {
        .init(
            get: { region },
            set: { newValue in DispatchQueue.main.async { region = newValue } }
        )
    }
    
    let locationManager = CLLocationManager()
    
    /// Current progress time expresed in seconds
    @State private var progressTime = 0
    @State private var isRunning = false
    @State private var showAlert = false
    @State private var isFullScreenMapPresented = false
    @State var backToHome: Bool = false
    /// Computed properties to get the progressTime in hh:mm:ss format
    var hours: Int {
        progressTime / 3600
    }
    
    var minutes: Int {
        (progressTime % 3600) / 60
    }
    
    var seconds: Int {
        progressTime % 60
    }
    
    /// Increase progressTime each second
    @State private var timer: Timer?
    
    //in order to make work big button and pedometer
    // Tracks whether the button is being pressed
    @GestureState private var isPressed = false
    // Controls the progress of the animation
    @State private var progressButton: CGFloat = 0.0
    // Timer to control the animation progress
    @State private var timerButton: Timer?
    @ObservedObject var pedometerManager = PedometerManager()
    @StateObject private var healthKitManager = HealthKitManager()
    
    //Character shared Values
    @AppStorage("progress", store: UserDefaults(suiteName: "character")) var progress: Double = 0.0
    @AppStorage("level", store: UserDefaults(suiteName: "character")) var level : Int = 1
    @AppStorage("skillpoint", store: UserDefaults(suiteName: "character")) var skillPoint: Int = 0
    @AppStorage("firstCompletation", store: UserDefaults(suiteName: "character")) var firstCompletation: Bool = false
    var distanceToComplete: Double
    
    @Query private var training: [TrainingSession]
    @Environment(\.modelContext) private var context
    
    var index:Int
    
    var body: some View {
        NavigationStack {
            NavigationLink(destination: HomePage(), isActive: self.$backToHome) { EmptyView() }
            NavigationLink(destination: ChooseCharacter(), isActive: self.$firstCompletation) { EmptyView() }
            
            Map (
                coordinateRegion: regionBinding,
                showsUserLocation: true,
                userTrackingMode: .constant(.follow)
            )
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                locationManager.requestWhenInUseAuthorization()
            }
            
            
            .frame(height: 200)
            .onTapGesture {
                isFullScreenMapPresented.toggle()
            }
            .fullScreenCover(isPresented: $isFullScreenMapPresented) {
                FullMapView()
            }
            //MARK: - Grid Session Recap
            VStack (spacing: 20) {
                LazyVGrid(columns: Array(repeating: GridItem(), count: 2), spacing: 100) {
                    
                    VStack {
                        Text("Steps")
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        Text("\(pedometerManager.steps)")
                            .font(.title3)
                            .fontWeight(.semibold)
                    }
                    VStack {
                        Text("Distance")
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        Text("\(pedometerManager.distanceInKilometers, specifier: "%.2f") km / \(distanceToComplete, specifier: "%.0f")km")
                            .font(.title3)
                            .fontWeight(.semibold)
                    }
                    VStack {
                        Text("Pace")
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        Text("\(pedometerManager.paceInMinutesPerKilometer, specifier: "%.2f") min/km")
                            .font(.title3)
                            .fontWeight(.semibold)
                    }
                    VStack {
                        Text("Calories")
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        Text("\((healthKitManager.caloriesBurned ), specifier: "%.2f")")
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                    }
                    
                }.padding(.all)
                //MARK: - Timer
                Spacer()
                VStack {
                    Text("Time")
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    HStack{
                        StopwatchUnit(timeUnit: hours, timeUnitText: "HR")
                        Text(":")
                            .font(.system(size: 25))
                        StopwatchUnit(timeUnit: minutes, timeUnitText: "MIN")
                        Text(":")
                            .font(.system(size: 25))
                        StopwatchUnit(timeUnit: seconds, timeUnitText: "SEC")
                    }
                }
                Spacer()
                //MARK: - BIG BUTTON
                ZStack(alignment: .leading) {
                    // The progress bar that will animate based on the press duration
                    Rectangle()
                        .foregroundColor(.gray.opacity(0.2))
                        .frame(height: 100)
                        .scaleEffect(x: progressButton, y: 1, anchor: .leading)
                        .animation(.linear, value: progressButton)
                    
                    // Button Label
                    Text(isRunning ? "Pause/Stop" : "Play/Stop")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .frame(width: 350, height: 100)
                .background(Color.gray.opacity(0.4))
                .cornerRadius(25)
                .contentShape(Rectangle())
                .onTapGesture {
                    self.addTraining()
                    if isRunning {
                        timer?.invalidate()
                    } else {
                        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
                            progressTime += 1
                        })
                    }
                    isRunning.toggle()
                }
                .gesture(
                    // A combined gesture to track pressing and dragging (with zero distance to act like a long press)
                    DragGesture(minimumDistance: 0)
                        .updating($isPressed) { _, isPressed, _ in
                            isPressed = true // Indicate that the button is being pressed
                        }
                        .onChanged { _ in
                            if timerButton == nil {
                                // Initialize and start the timer when the gesture begins
                                progressButton = 0.0 // Reset progress
                                timerButton = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
                                    // Increment the progress
                                    if progressButton < 1 {
                                        progressButton += 0.01
                                    }
                                }
                            }
                        }
                        .onEnded { _ in
                            // Invalidate and clear the timer when the gesture ends
                            showAlert.toggle()
                            timerButton?.invalidate()
                            timerButton = nil
                            progressButton = 0.0 // Reset the progress
                            
                        }
                )
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Are you sure?"),
                        message: Text("Stopping the timer will reset the progress. Do you want to continue?"),
                        primaryButton: .cancel(),
                        secondaryButton: .destructive(Text("Stop"), action: handleStop)
                    )
                }
                
            }.onAppear {
                pedometerManager.startPedometerUpdates()
                healthKitManager.requestAuthorization()
            }
            .onDisappear{
                healthKitManager.stopQueryingForCaloriesBurned()
            }
        }
    }
    
    func addTraining(){
        let training = TrainingSession(steps: 0, distance: 0.0, pace: 0.0, date: Date())
        context.insert(training)
    }
    
    func saveTrainingData(inedx:Int){
        training[index].steps = pedometerManager.steps
        training[index].distance = pedometerManager.distanceInKilometers
        training[index].pace = pedometerManager.paceInMinutesPerKilometer
        training[index].date = Date()
    }
    
    func checkProgressCharacter(){
        if progress < 1.0 {
            progress += 0.50
        }else{
            progress = 0.0
            level += 1
            skillPoint += 1
        }
    }
    
    private func handleStop() {
          // Invalidate the timer
          timer?.invalidate()
          isRunning = false
          progressTime = 0
          firstCompletation = true
          // Check if the user has completed the quest
          if pedometerManager.distanceInKilometers == distanceToComplete {
              // Handle quest completion
              checkProgressCharacter()
              saveTrainingData(inedx: training.count)
          }
          
          // Check if this is the first completion
          if firstCompletation {
              backToHome = true
          }
      }
}



