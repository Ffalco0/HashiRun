//
//  CharacterModel.swift
//  HashiRun
//
//  Created by Fabio Falco on 26/02/24.
//

import Foundation


class Character: ObservableObject {
    @Published var level : Int
    @Published var skillPoint = 0
    @Published var skills: [String]
    @Published var skillValue: [Int]
    
    init(level: Int = 1, skillPoint: Int = 0, skills: [String] = ["Strength", "Dexterity", "Wisdom"],skillValue: [Int]? = nil) {
        self.level = level
        self.skillPoint = skillPoint
        self.skills = skills
        self.skillValue = skillValue ?? Array(repeating: 0, count: skills.count)
    }
}
