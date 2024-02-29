//
//  Character.swift
//  HashiRun
//
//  Created by Fabio Falco on 23/02/24.
//

import SwiftUI
import SwiftData

struct CharacterView: View {
    @AppStorage("progress", store: UserDefaults(suiteName: "character")) var progress: Double = 0.0
    @AppStorage("level", store: UserDefaults(suiteName: "character")) var level : Int = 1
    @AppStorage("skillpoint", store: UserDefaults(suiteName: "character")) var skillPoint: Int = 0
    @AppStorage("image", store: UserDefaults(suiteName: "character")) var image: String = "wizard"
    private var skills: [String] = ["Strenght", "Dexstry","Wisdom"]
    
    
    @Environment(\.modelContext) private var context
    @Query private var skillValues: [Skill]
    
    var body: some View {
        
        NavigationStack{
            ZStack{
                Color("background").edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack{
                        //MARK: - Character section
                        Section {
                            Image(image)
                                .resizable()
                                .frame(width: 200.0, height: 250.0)
                                .clipShape(.rect)
                            
                            //MARK: - Level section
                            VStack{
                                Text("Lvl \(level)")
                                    .font(Font.custom("Press Start", size: 15))
                                //Start working on the progress bar
                                CustomProgressBar(progress: progress, imageName: "back")
                                    .padding()
                            }.padding()
                            Spacer()
                            //MARK: - Statistic section
                            VStack (alignment:.leading){
                                HStack {
                                    Text("SKILLS")
                                        .font(Font.custom("Press Start", size: 20))
                                        .padding(.horizontal)
                                    Spacer()
                                }
                                HStack{
                                    VStack{
                                        ForEach(0..<skills.count, id: \.self){index in
                                            Text(skills[index])
                                                .font(Font.custom("Press Start", size: 15))
                                                .padding()
                                        }
                                    }.padding()
                                    
                                    VStack{
                                        ForEach(0..<skills.count, id: \.self){index in
                                            Text("\(skillValues[skillValues.startIndex].skillValue[index])")
                                                .font(Font.custom("Press Start", size: 15))
                                                .padding()
                                        }
                                    }.padding()
                                    
                                    VStack{
                                        ForEach(0..<skills.count, id: \.self){index in
                                            Button {
                                                //Increase the skillvalues only if i have aviable skillPoints
                                                if skillPoint > 0{
                                                    skillValues[skillValues.startIndex].skillValue[index] += 1
                                                    skillPoint -= 1
                                                }
                                            } label: {
                                                Image(systemName: "plus")
                                            }.padding()
                                            
                                        }
                                    }.padding()
                                    
                                }
                            }
                        }
                        
                        Divider()
                            .frame(height: 20)
                        
                        Section{
                            //MARK: - Collectibles section
                            HStack {
                                Text("COLLECTIBLES")
                                    .font(Font.custom("Press Start", size: 20))
                                    .padding()
                                    .fontWeight(.bold)
                                Spacer()
                            }
                            CollectiblesView(images: ["bow","journal", "key", "potion","ring"])
                        }
                        
                    }
                    .navigationTitle("Name Of Your Adventurer")
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            HStack {
                                Text("\(skillPoint)")
                                    .font(Font.custom("Press Start", size: 15))
                                Image(systemName: "gear")
                            }
                        }
                    } 
                }
                
            }
            
        }
        
    }
    
}

