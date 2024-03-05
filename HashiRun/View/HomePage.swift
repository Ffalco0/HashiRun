//
//  ContentView.swift
//  HashiRun
//
//  Created by Fabio Falco on 23/02/24.
//

import SwiftUI
import SwiftData

struct HomePage: View {
    var missions: [String] = ["Explore the castle","Escape the forest","Talk to the seaman","Find the master sword"]
    @State var missionComplete:Int = 0
    @State var isClicked: [Bool]
    
    init() {
        _isClicked = State(initialValue: Array(repeating: false, count: missions.count))
    }
    
    @Environment(\.modelContext) private var context
    @Query private var skillValues: [Skill]
    @Query private var training: [TrainingSession]
    
    //Variabl to handle the charater window
    let images = ["bg", "bg1", "bg2"]
    @State private var randomImageName = "bg"
    let animationImages = ["human1", "human3", "human2"] // Replace with your image names
    let timer = Timer.publish(every: 1/5, on: .main, in: .common).autoconnect()
    @State var currentIndex = 0
    
    //Boss challenge
    var boss = Boss(values: [0,-1,-5])
    
    var body: some View {
        
        NavigationStack{
            ZStack {
                /*
                 LinearGradient(gradient: Gradient(colors: [Color("bg"),Color("bg2"),Color("bg"),Color("bg2")]), startPoint: .topLeading, endPoint: .bottomTrailing).edgesIgnoringSafeArea(.all)
                 */
                Color("background").edgesIgnoringSafeArea(.all)
                
                ScrollView{
                    
                    VStack{
                        VStack(){
                            NavigationLink(destination: CharacterView()) {
                                ZStack {
                                    
                                    /*
                                     Image(randomImageName)
                                     .resizable()
                                     .aspectRatio(contentMode: .fit)
                                     .frame(width: 280, height: 280).clipShape(RoundedRectangle(cornerRadius: 40))
                                     .onAppear {
                                     let randomIndex = Int.random(in: 0..<3)
                                     randomImageName = images[randomIndex]
                                     }
                                     */
                                    
                                    Circle()
                                        .foregroundColor(Color.gray)
                                        .frame(width:280)
                                        .opacity(0.5)
                                    
                                    Image(animationImages[currentIndex])
                                        .resizable()
                                        .frame(width: 175, height: 175)
                                    //.scaleEffect(0.5)
                                        .onReceive(timer) { _ in
                                            currentIndex = (currentIndex + 1) % animationImages.count
                                        }//.padding(.top, 100)
                                    
                                    
                                }
                                
                                
                            }
                            Text("Player class lvl ")
                                .font(Font.custom("Press Start", size: 20))
                        }
                        CustomDivider(textToDisplay: "Boss").padding(.vertical)
                        
                        Button {
                            self.battle()
                            
                        } label: {
                            ZStack{
                                Text("Challenge The Boss")
                                    .font(Font.custom("Press Start", size: 20))
                                    .fontWeight(.bold)
                                    .foregroundColor(.black) // Text color
                                    .padding(.vertical, 15) // Vertical padding
                                    .padding(.horizontal, 30) // Horizontal padding
                                    .frame(width: 300, height:80) // Set explicit frame size for the button
                                    .background(Color.red) // Button background color
                                    .cornerRadius(20) // Rounded corners
                                
                            }
                            
                        }
                        .shadow(color: .black, radius: 10, x: 0, y: 5) // Add shadow here
                        .padding()
                        
                        CustomDivider(textToDisplay: "Missions \(missionComplete)/\(missions.count)").padding(.vertical)
                        
                        
                        ForEach(0..<missions.count, id: \.self){index in
                            NavigationLink(destination: QuestCardFull(index: index,isClicked: $isClicked[index],tempComplementation: $missionComplete, title: missions[index])) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 25.0)
                                        .foregroundStyle(.clear)
                                        .background(isClicked[index] ? Image("buttonBg").opacity(0.2) :
                                                        Image("buttonBg").opacity(1))
                                    Text(missions[index])
                                        .font(Font.custom("Press Start", size: 15))
                                        .foregroundStyle(.black)
                                    
                                }
                            }
                            .foregroundColor(.white) // Ensure the text color is white if needed
                            .disabled(isClicked[index]) // Disable the button if it has been clicked
                            //.shadow(color: .black, radius: 10, x: 0, y: 5) // Add shadow here
                            .padding()
                        }.padding()
                        
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        HStack {
                            NavigationLink (destination: HistoryView()) {
                                Image("journal")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                            }
                        }
                    }
                }
            }.onAppear{
                if skillValues.isEmpty{
                    self.create()
                }
                
            }
            
        }
        .navigationBarBackButtonHidden()
    }
    
    
    private func create(){
        let skillsV = Skill(skillValue: [0,0,0])
        context.insert(skillsV)
    }
   
    
    
    //Temporary boss challenge
    private func battle(){
        var result:Int = 0
        for index in 0..<3 {
            result += challengeBoss(index: index)
        }
        if result > 1{
            print("You win the boss challenge")
        }else{
            print("You lose the boss challenge")
        }
    }
    
    private func challengeBoss(index: Int) -> Int{
        var points:Int = 0
        if skillValues[skillValues.startIndex].skillValue[index] > boss.values[index] {
            points += 1
        }
        return points
    }
    
    
}
