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
                    
                    Text("Amidst the ancient walls of the mysterious castle, our brave adventurers discovered secret passages and hidden chambers, unlocking the castle's enigmatic history. As they delved deeper, a glint of gold caught their eye, a long lost treasure concealed for centuries, now gleaming in the heart of the forgotten fortress, awaiting its rediscovery.")
                        .padding()
                        .font(.custom("Press Start", size: 18))
                    Spacer()
                    Text("Objective : 5 KM")
                        .font(.custom("Press Start", size: 18))
                    Spacer()
                    NavigationLink(destination: MissionView(distanceToComplete: 5)) {
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


