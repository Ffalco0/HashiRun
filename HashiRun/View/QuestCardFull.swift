//
//  QuestCardFull.swift
//  HashiRun
//
//  Created by Fabio Falco on 23/02/24.
//

import SwiftUI

struct QuestCardFull: View {
    var index:Int
    
    @Binding var isClicked: Bool
    @Binding var tempComplementation: Int
    
    var title: String
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("background").edgesIgnoringSafeArea(.all)
                
                VStack{
                    Text(title)
                        .padding()
                        .font(.custom("Press Start", size: 20))
                    
                    Spacer()
                    NavigationLink(destination: MissionView(distanceToComplete: 5, index: index)) {
                        Text("Start")
                            .foregroundColor(.white) // Text color
                            .padding(.vertical, 15) // Vertical padding
                            .padding(.horizontal, 30) // Horizontal padding
                            .frame(width: 300, height:80) // Set explicit frame size for the button
                            .background(Color.green) // Button background color
                            .cornerRadius(20) // Rounded corners
                    }
                    .id(UUID())
                    .foregroundColor(.white) // Ensure the text color is white if needed
                }
            }
        }
    }
}


