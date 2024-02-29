//
//  ContentView.swift
//  HashiRun
//
//  Created by Fabio Falco on 23/02/24.
//

import SwiftUI
import SwiftData

struct HomePage: View {
    var missions: [String] = ["Explore the castle","Escape in the forest","Go to talk to the man in the seaport","Find the master sword"]
    @State var missionComplete:Int = 0
    @State var isClicked: [Bool]
    
    init() {
        _isClicked = State(initialValue: Array(repeating: false, count: missions.count))
    }
    
    @Environment(\.modelContext) private var context
    @Query private var skillValues: [Skill]
    
    var body: some View {
        
        NavigationStack{
            ZStack{
                
                LinearGradient(gradient: Gradient(colors: [Color("bg"),Color("bg2"),Color("bg"),Color("bg2")]), startPoint: .topLeading, endPoint: .bottomTrailing).edgesIgnoringSafeArea(.all)
                
                ScrollView{
                    
                    VStack{
                        VStack(alignment:.leading){
                            NavigationLink(destination: CharacterView()) {
                                RoundedRectangle(cornerRadius: 50)
                                    .frame(width:300,height: 400)
                                    .foregroundColor(.clear)
                                    .background(
                                        Image("bg")
                                            .resizable()
                                            .scaledToFit()
                                    )
                            }
                        }
                        
                        Button(action: {
                            print(skillValues.count)
                        }, label: {
                            Text("tester for skillValues number")
                        })
                        
                        CustomDivider(textToDisplay: "Boss").padding(.vertical)
                        
                        Button {
                            print("Challenge the boss")
                        } label: {
                            ZStack{
                                Image("buttonBg")
                                    .resizable()
                                    .scaledToFit()
                                
                                Text("Challenge The Boss")
                                
                                /*
                                    .foregroundColor(.white) // Text color
                                    .padding(.vertical, 15) // Vertical padding
                                    .padding(.horizontal, 30) // Horizontal padding
                                    .frame(width: 300, height:80) // Set explicit frame size for the button
                                    .background(Color.red) // Button background color
                                    .cornerRadius(20) // Rounded corners
                                 */
                            }
                            
                        }
                        .foregroundColor(.white) // Ensure the text color is white if needed
                        .shadow(color: .black, radius: 10, x: 0, y: 5) // Add shadow here
                        .padding()
                        
                        CustomDivider(textToDisplay: "Missions \(missionComplete)/\(missions.count)").padding(.vertical)
                        
                        
                        ForEach(0..<missions.count, id: \.self){index in
                            NavigationLink(destination: QuestCardFull(isClicked: $isClicked[index],tempComplementation: $missionComplete, title: missions[index])) {
                               /*
                                ZStack{
                                    Image("buttonBg")
                                        .resizable()
                                        .scaledToFit()
                                    
                                    Text(missions[index])
                                }*/
                                
                                Text(missions[index])
                                    .foregroundColor(.white) // Text color
                                    .padding(.vertical, 15) // Vertical padding
                                    .padding(.horizontal, 30) // Horizontal padding
                                    .frame(width: 300, height:80) // Set explicit frame size for the button
                                    .background(Color("button")) // Button background color
                                    .cornerRadius(20) // Rounded corners
                              
                            }
                            .foregroundColor(.white) // Ensure the text color is white if needed
                            .disabled(isClicked[index]) // Disable the button if it has been clicked
                            .shadow(color: .black, radius: 10, x: 0, y: 5) // Add shadow here
                        }.padding()
                        
                    }
                }
            }.onAppear{
                if skillValues.isEmpty{
                    self.create()
                }
            }
        }
    }
    
    private func create(){
        let skillsV = Skill(skillValue: [0,0,0])
        context.insert(skillsV)
    }
    
    
}
