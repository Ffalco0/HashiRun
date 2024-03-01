//
//  SmallMapView.swift
//  RunningRPG
//
//  Created by Lorenzo Overa on 20/02/24.
//

import SwiftUI
import MapKit
import CoreLocation

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
    @State private var progress: CGFloat = 0.0
    @ObservedObject var pedometerManager = PedometerManager()
    @StateObject private var healthKitManager = HealthKitManager()

    
    var body: some View {
        NavigationStack {
            NavigationLink(destination: HomePage(), isActive: self.$backToHome) { EmptyView() }
            
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
                        
                        Text("\(pedometerManager.distanceInKilometers, specifier: "%.2f") km")
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
                        
                        Text("\(healthKitManager.caloriesBurned, specifier: "%.2f")")
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
                VStack(spacing: 20) {
                    HStack(spacing: 20) {
                        ZStack {
                            
                            GeometryReader { geometry in
                                RoundedRectangle(cornerRadius: 25.0)
                                    .fill(LinearGradient(gradient: Gradient(colors: [.gray]), startPoint: .leading, endPoint: .trailing))
                                    .frame(width: geometry.size.width * progress, height: geometry.size.height)
                                    .animation(.linear(duration: 3), value: progress)
                            }
                            .mask(
                                RoundedRectangle(cornerRadius: 25.0)
                                    .frame(width: 350, height: 100)
                            )

                            
                            RoundedRectangle(cornerRadius: 25.0)
                                .fill(Color.gray)
                                .frame(width: 350, height: 100)
                            
                                .onTapGesture {
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
                                    LongPressGesture(minimumDuration: 3.0)
                                      
                                        .onEnded { _ in
                                            showAlert = true
                                        }
                                )
                            
                           
                            
                            Text(isRunning ? "Pause/Stop" : "Play/Stop")
                                .font(.title)
                        }
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Are you sure?"),
                            message: Text("Stopping the timer will reset the progress. Do you want to continue?"),
                            primaryButton: .cancel(),
                            secondaryButton: .destructive(Text("Stop"), action: {
                                timer?.invalidate()
                                isRunning = false
                                progressTime = 0
                                self.backToHome = true // Trigger navigation or state change
                            })
                        )
                    }
                    
                    /*
                    HStack(spacing: 20) {
                        Button(action: {
                            if isRunning {
                                timer?.invalidate()
                            } else {
                                timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
                                    progressTime += 1
                                })
                            }
                            isRunning.toggle()
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 25.0)
                                    .fill(Color.gray)
                                    .opacity(0.4)
                                    .frame(width: 350, height: 100)
                                
                                Text(isRunning ? "Pause/Stop" : "Play/Stop")
                                    .font(.title)
                                    .foregroundColor(.black)
                            }
                        }
                        .gesture(LongPressGesture(minimumDuration: 3.0)
                            .onEnded { _ in
                                showAlert = true
                                print(showAlert)
                        })
                        .alert(isPresented: $showAlert) {
                            Alert(
                                title: Text("Are you sure?"),
                                message: Text("Stopping the timer will reset the progress. Do you want to continue?"),
                                primaryButton: .cancel(),
                                secondaryButton: .destructive(Text("Stop"), action: {
                                    timer?.invalidate()
                                    isRunning = false
                                    progressTime = 0
                                    self.backToHome = true
                                })
                            )
                        }
                    }*/
                }
            } .onAppear {
                pedometerManager.startPedometerUpdates()
                healthKitManager.requestAuthorization()
            }
        }
        .navigationBarBackButtonHidden()
    }
}


#Preview {
    MissionView()
}

