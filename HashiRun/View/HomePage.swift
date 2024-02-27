//
//  ContentView.swift
//  HashiRun
//
//  Created by Fabio Falco on 23/02/24.
//

import SwiftUI

struct HomePage: View {
    var missions: [String] = ["Explore the castle","Escape in the forest","Go to talk to the man in the seaport","Find the master sword"]
    @State var missionComplete:Int = 0
    @State var isClicked: [Bool]
    
    @ObservedObject var counter: Counter
    init(progress: Counter) {
        _isClicked = State(initialValue: Array(repeating: false, count: missions.count))
        self._counter = ObservedObject(initialValue: progress)
    }
    
    @StateObject var character = Character()
    
    var body: some View {
        
        NavigationStack{
            ZStack{
                LinearGradient(gradient: Gradient(colors: [Color("bg"),Color("bg2"),Color("bg"),Color("bg2")]), startPoint: .topLeading, endPoint: .bottomTrailing).edgesIgnoringSafeArea(.all)
                ScrollView{
                    
                    VStack{
                        VStack(alignment:.leading){
                            NavigationLink(destination: CharacterView(progress: counter)) {
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
                        
                        CustomDivider(textToDisplay: "Boss")
                        
                        Button {
                            print("Challenge the boss")
                        } label: {
                            Text("Challenge The Boss")
                                .foregroundColor(.white) // Text color
                                .padding(.vertical, 15) // Vertical padding
                                .padding(.horizontal, 30) // Horizontal padding
                                .frame(width: 300, height:80) // Set explicit frame size for the button
                                .background(Color.red) // Button background color
                                .cornerRadius(20) // Rounded corners
                        }
                        .foregroundColor(.white) // Ensure the text color is white if needed
                        .shadow(color: .black, radius: 10, x: 0, y: 5) // Add shadow here
                        .padding()
                        
                        CustomDivider(textToDisplay: "Missions \(missionComplete)/\(missions.count)")
                        
                        
                        ForEach(0..<missions.count, id: \.self){index in
                            NavigationLink(destination: QuestCardFull(isClicked: $isClicked[index],tempComplementation: $missionComplete, title: missions[index], progress: counter)) {
                                Text(missions[index])
                                    .foregroundColor(.white) // Text color
                                    .padding(.vertical, 15) // Vertical padding
                                    .padding(.horizontal, 30) // Horizontal padding
                                    .frame(width: 300, height: 80) // Set explicit frame size for the button
                                    .background(isClicked[index] ? Color("button").opacity(0.5) : Color("button").opacity(1.0)) // Button background color
                                    .cornerRadius(20) // Rounded corners
                            }
                            .foregroundColor(.white) // Ensure the text color is white if needed
                            .disabled(isClicked[index]) // Disable the button if it has been clicked
                            .shadow(color: .black, radius: 10, x: 0, y: 5) // Add shadow here
                        }.padding()
                        
                    }
                }

                }.environmentObject(character)
            }
        }
    }

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage(progress: Counter())
    }
}
