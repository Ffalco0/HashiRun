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
    let imageName: String
    let description: String
}

let quests: [Quest] = [
    Quest(name: "Distance Explorer", imageName: "key", description: "Urban Explorer"),
    Quest(name: "Elevation", imageName: "key", description: "Summit Seeker"),
    Quest(name: "Streak Runner", imageName: "key", description: "Daily Dynamo"),
    Quest(name: "Speed Demon", imageName: "key", description: "Velocity Victor"),
    Quest(name: "Charity Run", imageName: "key", description: "Trail Blazer"),
    Quest(name: "Compassionate Runner", imageName: "key", description: "Trail Blazer")
]

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
              Color("background").edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack {
                        // Quests
                        VStack(alignment: .leading, spacing: 15) {
                           
                            
                            ForEach(quests) { quest in
                                NavigationLink(destination: QuestDetailView(quest: quest)) {
                                    HStack(alignment: .center, spacing: 10) {
                                        // Image with Circle background
                                        ZStack{
                                            Circle()
                                                .foregroundColor(Color.gray)
                                                .opacity(0.5)
                                            Image(quest.imageName)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 70, height: 70)
                                        }
                                        
                                        Spacer()
                                        
                                        // Quest name
                                        ZStack(alignment: .center){
                                            RoundedRectangle(cornerRadius: 50)
                                                .foregroundColor(Color.gray)
                                                .frame(width:280)
                                                .opacity(0.5)
                                            VStack(alignment: .leading) {
                                                Text(quest.name)
                                                    .font(.custom("prstart.tiff", size: 20))
                                                    .fontWeight(.bold)
                                                    .foregroundColor(Color.white)

                                                Text(quest.description)
                                                    .font(.custom("prstart.tiff", size: 15))
                                                    .fontWeight(.semibold)
                                                    .foregroundColor(Color.white)
                                            }
                                        }
                                    }
                                    .padding() // Add padding to each item if needed
                                }
                                .navigationBarTitle("Quests", displayMode: .automatic)
                                .navigationBarTitleDisplayMode(.automatic)
                                
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
    @Environment(\.modelContext) private var context
    @Query private var training: [TrainingSession]
    var body: some View {
            ZStack {
                Color("background").edgesIgnoringSafeArea(.all)
                VStack {
                    // Image with Circle background
                    ZStack {
                        Circle()
                            .foregroundColor(Color.gray)
                            .opacity(0.5)
                            .frame(height: 100)
                        Image("key")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                    }
                    
                    Text(quest.name)
                        .font(.custom("prstart.tiff", size: 22))
                        .fontWeight(.bold)
                        .foregroundColor(Color.yellow)
                        .lineLimit(1)
                    
                    Text("Explore your city or town by running a certain distance in different areas. Uncover hidden gems, scenic views, and new landmarks as you venture through parks, waterfronts, and diverse neighborhoods.")
                        .font(.custom("prstart.tiff", size: 18))
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .lineLimit(nil)
                        .multilineTextAlignment(.leading)
                    
                    
                    VStack(alignment: .center){
                        ForEach(0..<training.count, id: \.self) { index in
                            Text("Steps: \(training[index].steps)")
                            Text("Distance: \(training[index].distance, specifier: "%.2f") km")
                            Text("Pace: \(training[index].pace, specifier: "%.2f") min/km")
                            Text("Date: \(formatDate(training[index].date))")
                        }.padding()
                    }
                }
                .padding()
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
        ContentView()
    }
}
