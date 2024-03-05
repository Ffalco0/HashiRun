//
//  HashiRunApp.swift
//  HashiRun
//
//  Created by Fabio Falco on 23/02/24.
//

import SwiftUI
import SwiftData

@main
struct HashiRunApp: App {
    var container: ModelContainer
    
    init() {
        do{
            
            container = try ModelContainer(for: Skill.self, TrainingSession.self)
            
        }catch{
            fatalError("Failed to configure SwiftData container.")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            HomePage()
        }
        .modelContainer(container)
    }
}
