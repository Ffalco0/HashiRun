//
//  ContentView.swift
//  HashiRun
//
//  Created by Fabio Falco on 23/02/24.
//

import SwiftUI
import SwiftData

struct HomePage: View {
    var missions: [String] = [String(localized: "Explore the castle"),String(localized: "Escape the forest"),String(localized: "Talk to the seaman"),String(localized: "Find the master sword")]
    @State var missionComplete: Int = 0
    @State var isClicked: [Bool]
    
    init() {
        _isClicked = State(initialValue: Array(repeating: false, count: missions.count))
    }
    
    @Environment(\.modelContext) private var context
    @Query private var skillValues: [Skill]
    @Query private var training: [TrainingSession]
    
    @AppStorage("image", store: UserDefaults(suiteName: "character")) var image: String = "human1"
    @State var imageDic = ["human1": ["human1", "human2", "human3"],
                           "mage11": ["mage11", "mage12", "mage13"],
                           "mage2": ["mage21", "mage22", "mage23"],
                           "mage3": ["mage31", "mage32", "mage33"],
                           "rogue11": ["rogue11", "rogue12", "rogue13"],
                           "rogue2": ["rogue21", "rogue22", "rogue23"],
                           "rogue3": ["rogue31", "rogue32", "rogue33"],
                           "warrior11": ["warrior11", "warrior12", "warrior13"],
                           "warrior2": ["warrior21", "warrior22", "warrior23"],
                           "warrior3": ["warrior31", "warrior32", "warrior33"]]
    
    let timer = Timer.publish(every: 1/5, on: .main, in: .common).autoconnect()
    @State var currentIndex = 0
    
    @State private var showingBattleResult = false
    @State private var battleResult = ""
    
    @AppStorage("firstCompletation", store: UserDefaults(suiteName: "character")) var firstCompletation: Bool = false
    @AppStorage("choosedCharacter", store: UserDefaults(suiteName: "character")) var choosedCharacter: Bool = false
    //Boss challenge
    var boss = Boss(values: [0,-1,-1])
    
    var body: some View {
        
        NavigationStack{
            ZStack {
                Color("background").edgesIgnoringSafeArea(.all)
                
                ScrollView{
                    VStack{
                        VStack(){
                            NavigationLink(destination: choosedCharacter ?  AnyView(ChooseCharacter()) : AnyView(CharacterView())){
                                ZStack {
                                    Circle()
                                        .foregroundColor(Color.gray)
                                        .frame(width:280)
                                        .opacity(0.5)
                                    
                                    Image(imageDic[image]==nil ? imageDic["human"]![currentIndex] : imageDic[image]![currentIndex])
                                        .resizable()
                                        .frame(width: 175, height: 175)
                                        .onReceive(timer) { _ in
                                            currentIndex = (currentIndex + 1) % 3
                                        }
                                }
                                
                            }
                            
                            Text("Human base lvl l")
                                .font(Font.custom("Press Start", size: 20)).foregroundStyle(Color.orangeSlide).padding()
                        }
                        CustomDivider(textToDisplay: "Boss").padding(.vertical)
                        Button {
                            showingBattleResult = true
                            
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
                        .disabled(!firstCompletation)
                        .opacity(firstCompletation ? 1.0 : 0.5)
                        .shadow(color: .black, radius: 10, x: 0, y: 5) // Add shadow here
                        .padding()
                        
                        CustomDivider(textToDisplay: "Missions \(missionComplete)/\(missions.count)").padding(.vertical)
                        
                        
                        ForEach(0..<missions.count, id: \.self){index in
                            NavigationLink(destination: QuestCardFull(index: index,isClicked: $isClicked[index],tempComplementation: $missionComplete, title: missions[index])) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 25.0)
                                        .foregroundStyle(.clear)
                                        .background(isClicked[index] ? Image("buttonBg").opacity(0.2) : Image("buttonBg").opacity(1))
                                    Text(String(missions[index]))
                                        .font(Font.custom("Press Start", size: 15))
                                        .foregroundStyle(.black)
                                }
                            }
                            .foregroundColor(.white)
                            .disabled(isClicked[index])
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
            .fullScreenCover(isPresented: $showingBattleResult, onDismiss: {
                print("Tornato alla HomePage")
            }) {
                BattleResultView(result: self.battle(), onDismiss: {
                    self.showingBattleResult = false
                })
            }
        }
            .navigationBarBackButtonHidden()
    }
    
    
    private func create(){
        let skillsV = Skill(skillValue: [0,0,0])
        let train = TrainingSession(steps: 0, distance: 0.0, pace: 0.0, date: Date())
        context.insert(skillsV)
        context.insert(train)
        
    }
    
    
    
    //Temporary boss challenge
    private func battle() -> String{
        var result:Int = 0
        for index in 0..<3 {
            result += challengeBoss(index: index)
        }
        if result > 1{
            return "You BEAT the boss !!"
        }else{
            return "DEFEATED"
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



