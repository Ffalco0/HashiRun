//
//  QuestView.swift
//  HashiRun
//
//  Created by nagarjuna chagarlamudi on 27/02/24.
//

import SwiftUI

struct Quest: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
}

let quests: [Quest] = [
    Quest(name: "Distance Explorer", imageName: "distance_explorer"),
    Quest(name: "Urban Explorer", imageName: "urban_explorer"),
    Quest(name: "Elevation", imageName: "elevation"),
    Quest(name: "Summit Seeker", imageName: "summit_seeker"),
    Quest(name: "Streak Runner", imageName: "streak_runner"),
    Quest(name: "Daily Dynamo", imageName: "daily_dynamo"),
    Quest(name: "Speed Demon", imageName: "speed_demon"),
    Quest(name: "Velocity Victor", imageName: "velocity_victor"),
    Quest(name: "Charity Run", imageName: "charity_run"),
    Quest(name: "Compassionate Runner", imageName: "compassionate_runner"),
    Quest(name: "Trail Blazer", imageName: "trail_blazer"),
    Quest(name: "Nature Navigator", imageName: "nature_navigator")
]

struct ContentView: View {
    var body: some View {
        ZStack {
            Color("bg")
                .ignoresSafeArea(edges: .all)
            
            NavigationView {
                List(quests) { quest in
                    NavigationLink(destination: QuestDetailView(quest: quest)) {
                        HStack {
                            Image(quest.imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                            Text(quest.name)
                        }
                    }
                }
                .navigationTitle("Quests")
            }
        }
    }
}


struct QuestDetailView: View {
    let quest: Quest
    
    var body: some View {
        VStack {
            Image(quest.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity, maxHeight: 200)
            Text(quest.name)
                .font(.largeTitle)
                .colorInvert()
                .padding()
            Spacer()
        }
        .background(Color("bg2"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
