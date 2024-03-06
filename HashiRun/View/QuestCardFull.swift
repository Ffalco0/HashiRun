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
                    Spacer()
                    
                    Text(title)
                            .font(.custom("Press Start", size: 20))
        
                    Spacer()
                    
                    Text("Amidst the ancient walls of the mysterious castle, our brave adventurer discovered secret passages and hidden chambers, unlocking the castle's enigmatic history. As the delved deeper, a glint of gold caught his eye, a long lost treasure concealed for centuries, now gleaming in the heart of the forgotten fortress, awaiting its rediscovery.")
                        .padding()
                        .font(.custom("Press Start", size: 18))
                    
                    Spacer()
                    
                    Text("Objective : 5 KM")
                        .font(.custom("Press Start", size: 18))
                    
                    NavigationLink(destination: MissionView(distanceToComplete: 5)) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25.0)
                                .foregroundStyle(.clear)
                            Image("buttonBg")
                            Text("Start")
                                .font(Font.custom("Press Start", size: 15))
                                .foregroundStyle(.black)
                            
                        }
                    }
                    .padding(.top, 150)
                    .id(UUID())
                    
                }
            }
        }
    }
}


