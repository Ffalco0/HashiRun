//
//  StopWatchViewModel.swift
//  RunningRPG
//
//  Created by Lorenzo Overa on 20/02/24.
//
import SwiftUI

class StopwatchViewModel: ObservableObject {
    @Published var seconds = 0
    @State var timer: Timer?

    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            self?.updateTime()
        }
    }

    func pause() {
        timer?.invalidate()
        timer = nil
    }

    func stop() {
        timer?.invalidate()
        timer = nil
        seconds = 0
    }

    func updateTime() {
        seconds += 1
    }
}
