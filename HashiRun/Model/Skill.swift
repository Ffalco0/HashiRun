//
//  Skill.swift
//  HashiRun
//
//  Created by Fabio Falco on 28/02/24.
//

import Foundation
import SwiftData

@Model class Skill{
    var skillValue: [Int]
    
    init(skillValue: [Int]) {
        self.skillValue = skillValue
    }
}
