//
//  QuestCardFull.swift
//  HashiRun
//
//  Created by Fabio Falco on 23/02/24.
//

import SwiftUI

struct QuestCardFull: View {
    @Binding var isClicked: Bool
    @Binding var tempComplementation: Int
    
    var title: String
    
    @ObservedObject var progress: Counter
    @EnvironmentObject var character: Character
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color("background").edgesIgnoringSafeArea(.all)
                
                VStack{
                    Text(title)
                        .colorInvert()
                    Spacer()
                    Button {
                        isClicked = true
                        tempComplementation += 1
                        if progress.progress < 1.0 {
                            progress.progress += 0.50
                        }else{
                            progress.progress = 0.0
                            character.level += 1
                            character.skillPoint += 1
                        }
                    } label: {
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
            }
        }
    }
}


