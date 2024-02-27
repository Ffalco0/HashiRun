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
    Quest(name: "Distance Explorer", imageName: "coll 1"),
    Quest(name: "Urban Explorer", imageName: "coll 2"),
    Quest(name: "Elevation", imageName: "coll 2"),
    Quest(name: "Summit Seeker", imageName: "coll 2"),
    Quest(name: "Streak Runner", imageName: "coll 2"),
    Quest(name: "Daily Dynamo", imageName:"coll 2"),
    Quest(name: "Speed Demon", imageName: "coll 2"),
    Quest(name: "Velocity Victor", imageName: "coll 2"),
    Quest(name: "Charity Run", imageName: "coll 2"),
    Quest(name: "Compassionate Runner", imageName: "coll 2"),
    Quest(name: "Trail Blazer", imageName: "coll 2"),
    Quest(name: "Nature Navigator", imageName: "coll 2")
]

struct ContentView: View {
    var body: some View {
        
        NavigationView {
            VStack(alignment: .leading, spacing: 50) {
                ForEach(quests) { quest in
                    NavigationLink(destination: QuestDetailView(quest: quest)) {
                        HStack {
                            Image(quest.imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                                .background(
                                    Circle()
                                        .foregroundColor(.gray)
                                        .opacity(0.8)
                                        .frame(width: 60, height: 60)
                                )
                            Text(quest.name)
                                .font(.title)
                                .background(
                                    RoundedRectangle(cornerRadius: 9, style: .continuous)
                                        .foregroundStyle(.gray)
                                        .opacity(0.8)
                                )
                        }
                    }
                }
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
