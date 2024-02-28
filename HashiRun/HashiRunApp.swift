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
    var body: some Scene {
        WindowGroup {
            HomePage()
        }.modelContainer(for: Skill.self)
    }
}
