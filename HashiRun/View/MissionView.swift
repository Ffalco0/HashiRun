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
            
            VStack (spacing: 20) {
                Spacer()
                ZStack {
                    RoundedRectangle(cornerRadius: 25.0)
                        .fill(Color.gray)
                        .opacity(0.1)
                        .frame(width: 300, height: 250)
                        .padding()
                }
                
                Spacer()
                
                VStack(spacing: 20) {
                    HStack(spacing: 20) {
                        ZStack {
                            VStack {
                                Text("Time")
                                //.padding(1)
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                HStack(spacing: 5) {
                                    StopwatchUnit(timeUnit: hours, timeUnitText: "HR")
                                    Text(":")
                                        .font(.system(size: 25))
                                    StopwatchUnit(timeUnit: minutes, timeUnitText: "MIN")
                                    Text(":")
                                        .font(.system(size: 25))
                                    StopwatchUnit(timeUnit: seconds, timeUnitText: "SEC")
                                }
                            }
                            RoundedRectangle(cornerRadius: 25.0)
                                .fill(Color.gray)
                                .opacity(0.4)
                                .frame(width: 170, height: 100)
                        }
                        
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(Color.gray)
                            .opacity(0.4)
                            .frame(width: 170, height: 100)
                            .overlay(
                                VStack {
                                    Text("Distance")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                }
                            )
                    }
                    
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
                                    .frame(width: 170, height: 100)
                                
                                Image(isRunning ? "pause" : "play")
                                    .font(.title)
                                    .foregroundColor(.white)
                            }
                        }
                        

                        Button(action: {
                            showAlert = true
                            //progressTime = 0
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 25.0)
                                    .fill(Color.gray)
                                    .opacity(0.4)
                                    .frame(width: 170, height: 100)
                                
                                Image("stop")
                                    .font(.title)
                                    .foregroundColor(.white)
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
                                    self.backToHome = true
                                })
                            )
                        }
                    }
                    
                    Spacer()
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}


#Preview {
    MissionView()
}

