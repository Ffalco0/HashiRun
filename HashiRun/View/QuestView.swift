//
//  QuestView.swift
//  HashiRun
//
//  Created by nagarjuna chagarlamudi on 29/02/24.
//

import SwiftUI
import SwiftData

struct Quest: Identifiable {
    let id = UUID()
    let name: String
    
    let description: String
}

let quests: [Quest] = [
    Quest(name: String(localized: "Navigate the unknown"), description: "10 KM"),
    Quest(name: String(localized: "Find the magic lake"), description: "5 KM"),
    Quest(name: String(localized: "Escape from the demonic monsters"), description: "2 KM"),
    Quest(name: String(localized: "Walk through the city of Atlantis"), description: "8 KM")
]

struct HistoryView: View {
    @Environment(\.modelContext) private var context
    @Query private var training: [TrainingSession]
    var body: some View {
        NavigationStack {
            ZStack {
              Color("background").edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack {
                        // Quests
                        VStack(alignment: .leading, spacing: 15) {
                            ForEach(0..<quests.count, id: \.self) { index in
                                NavigationLink(destination: QuestDetailView(quest: quests[index],index: index)) {
                                    HStack(spacing: 10) {
                                        
                                        // Quest name
                                        ZStack(){
                                            RoundedRectangle(cornerRadius: 25)
                                                .foregroundColor(Color.gray)
                                                .frame(width:350)
                                                .opacity(0.5)
                                            VStack(spacing: 10) {
                                                Text(quests[index].name)
                                                    .font(Font.custom("Press Start", size: 15))
                                                    .fontWeight(.bold)
                                                    .foregroundColor(Color.white)

                                                Text(quests[index].description)
                                                    .font(Font.custom("Press Start", size: 15))
                                                    .fontWeight(.semibold)
                                                    .foregroundColor(Color.white)
                                            }.padding()
                                        }
                                    }
                                    
                                }
                                .navigationBarTitle("History")
                                
                                
                            }
                        }
                        
                    }
                }
            }
        }.environment(\.colorScheme, .dark)
    }
 
}

struct QuestDetailView: View {
    var quest: Quest
    var index: Int
    @Environment(\.modelContext) private var context
    @Query private var training: [TrainingSession]
    var body: some View {
            ZStack {
                Color("background").edgesIgnoringSafeArea(.all)
                VStack(spacing: 20) {
                    Text(quest.name)
                        .font(Font.custom("Press Start", size: 25))
                        .fontWeight(.bold)
                        .foregroundStyle(.accent)
                    
                    Text("Explore your city or town by running a certain distance in different areas. Uncover hidden gems, scenic views, and new landmarks as you venture through parks, waterfronts, and diverse neighborhoods.")
                        .font(Font.custom("Press Start", size: 18))
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.leading)
                    
                    
                    VStack(alignment: .leading, spacing: 20){
                        if index < training.count{
                            HStack {
                                Text("Steps:")
                                    .font(Font.custom("Press Start", size: 20))
                                    .foregroundStyle(Color.orangeSlide)
                                Text("\(training[index].steps)")
                                    .font(Font.custom("Press Start", size: 20))
                            }
                            HStack {
                                Text("Distance:")
                                    .font(Font.custom("Press Start", size: 20))
                                    .foregroundStyle(Color.orangeSlide)
                                Text(" \(training[index].distance, specifier: "%.2f")km")
                                    .font(Font.custom("Press Start", size: 20))
                            }
                            HStack {
                                Text("Pace:")
                                    .font(Font.custom("Press Start", size: 20))
                                    .foregroundStyle(Color.orangeSlide)
                                Text("\(training[index].pace, specifier: "%.2f") km/min")
                                    .font(Font.custom("Press Start", size: 20))
                            }
                            HStack {
                                Text("Date:")
                                    .font(Font.custom("Press Start", size: 20))
                                    .foregroundStyle(Color.orangeSlide)
                                Text("\(formatDate(training[index].date))")
                                    .font(Font.custom("Press Start", size: 20))
                            }

                        }else{
                            Text("No data recorded for the Beta Version")
                        }
                    }
                }
                .padding()
                .padding(.top, -200)
            }
    }
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
