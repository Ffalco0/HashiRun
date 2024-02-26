//
//  Character.swift
//  HashiRun
//
//  Created by Fabio Falco on 23/02/24.
//

import SwiftUI


struct CharacterView: View {
    @ObservedObject var progress: Counter
    init(progress: Counter) {
        self._progress = ObservedObject(initialValue: progress)
    }
    
    @EnvironmentObject var character: Character
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color("background").edgesIgnoringSafeArea(.all)
                ScrollView {
                    VStack{
                        //MARK: - Character section
                        Section {
                            Image("wizard")
                                .resizable()
                                .frame(width: 200.0, height: 250.0)
                                .clipShape(.rect)
                            //MARK: - Level section
                            VStack{
                                Text("Lvl \(character.level)")
                                    .font(Font.custom("Press Start", size: 15))
                                //Start working on the progress bar
                                CustomProgressBar(progress: progress.progress, imageName: "back")
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
                                        ForEach(0..<character.skills.count, id: \.self){index in
                                            Text(character.skills[index])
                                                .font(Font.custom("Press Start", size: 15))
                                                .padding()
                                        }
                                    }.padding()
                                    
                                    VStack{
                                        ForEach(0..<character.skillValue.count, id: \.self){index in
                                            Text("\(character.skillValue[index])")
                                                .font(Font.custom("Press Start", size: 15))
                                                .padding()
                                        }
                                    }.padding()
                                    
                                    VStack{
                                        ForEach(0..<character.skillValue.count, id: \.self){index in
                                            Button {
                                                if character.skillPoint > 0{
                                                    character.skillValue[index] += 1
                                                    character.skillPoint -= 1
                                                }
                                            } label: {
                                                Image(systemName: "plus")
                                            }.padding()

                                        }
                                    }.padding()
                                    
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
                                CollectiblesView(images: ["coll 1", "coll 2", "coll 3", "coll 4"])
                            }
                        }
                    }
                    .navigationTitle("The knight")
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            HStack {
                                Text("\(character.skillPoint)")
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

