//
//  SharedValue.swift
//  HashiRun
//
//  Created by Fabio Falco on 24/02/24.
//

import Foundation
import Combine


class Counter: ObservableObject {
    @Published var progress: Double = 0.0 {
        didSet {
            print("Progress is now \(progress)")
        }
    }
}
