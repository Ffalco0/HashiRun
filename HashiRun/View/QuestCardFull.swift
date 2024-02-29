//
//  QuestCardFull.swift
//  HashiRun
//
//  Created by Fabio Falco on 23/02/24.
//

import SwiftUI

struct QuestCardFull: View {
    //Character shared Values
    @AppStorage("progress", store: UserDefaults(suiteName: "character")) var progress: Double = 0.0
    @AppStorage("level", store: UserDefaults(suiteName: "character")) var level : Int = 1
    @AppStorage("skillpoint", store: UserDefaults(suiteName: "character")) var skillPoint: Int = 0
    
    @Binding var isClicked: Bool
    @Binding var tempComplementation: Int
    
    var title: String
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color("background").edgesIgnoringSafeArea(.all)
                
                VStack{
                    Text(title)
                        .padding()
                        .font(.custom("Press Start", size: 20))
                    
                    Spacer()
                    
                    Button {
                        self.isClicked = true
                        
                        tempComplementation += 1
                        
                        
                        if progress < 1.0 {
                            progress += 0.50
                        }else{
                            progress = 0.0
                            level += 1
                            skillPoint += 1
                        }
                    }
                    
                label: {
                    Text("Start")
                        .foregroundColor(.white) // Text color
                        .padding(.vertical, 15) // Vertical padding
                        .padding(.horizontal, 30) // Horizontal padding
                        .frame(width: 300, height:80) // Set explicit frame size for the button
                        .background(isClicked ? Color.green.opacity(0.5) : Color.green.opacity(1.0)) // Button background color
                        .cornerRadius(20) // Rounded corners
                }
                .foregroundColor(.white) // Ensure the text color is white if needed
                .disabled(isClicked)
                    
                }
                .background(
                    NavigationLink(destination: MissionView(), isActive: $isClicked) {
                        EmptyView()
                    }
                        .hidden()
                )
            }
            
        }
        
    }
}


