//
//  StopWatch.swift
//  HashiRun
//
//  Created by Lorenzo Overa on 29/02/24.
//

import SwiftUI

struct Stopwatch: View {

    /// Current progress time expresed in seconds
    @State private var progressTime = 0
    @State private var isRunning = false

    /// Computed properties to get the progressTime in hh:mm:ss format
    var hours: Int {
        progressTime / 3600
    }

    var minutes: Int {
        (progressTime % 3600) / 60
    }

    var seconds: Int {
        progressTime % 60
    }

    /// Increase progressTime each second
    @State private var timer: Timer?

    var body: some View {
        VStack(spacing: 20) {
            HStack(spacing: 20) {
                ZStack {
                    VStack {
                        Text("Time")
                            //.padding(1)
                            .font(.title3)
                            .fontWeight(.semibold)
                        HStack(spacing: 5) {
                            StopwatchUnit(timeUnit: hours, timeUnitText: "HR")
                            Text(":")
                                .font(.system(size: 25))
                            StopwatchUnit(timeUnit: minutes, timeUnitText: "MIN")
                            Text(":")
                                .font(.system(size: 25))
                            StopwatchUnit(timeUnit: seconds, timeUnitText: "SEC")
                        }
                    }
                    RoundedRectangle(cornerRadius: 25.0)
                        .fill(Color.gray)
                        .opacity(0.4)
                        .frame(width: 170, height: 100)
                }
                
                RoundedRectangle(cornerRadius: 25.0)
                    .fill(Color.gray)
                    .opacity(0.4)
                    .frame(width: 170, height: 100)
                    .overlay(
                        VStack {
                            Text("Distance")
                                .font(.title3)
                                .fontWeight(.semibold)
                        }
                    )
            }
            
            HStack(spacing: 20) {
                Button(action: {
                    if isRunning{
                        timer?.invalidate()
                    } else {
                        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
                            progressTime += 1
                        })
                    }
                    isRunning.toggle()
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(Color.gray)
                            .opacity(0.4)
                            .frame(width: 170, height: 100)
                        
                        Image(isRunning ? "pause" : "play")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                }

                Button(action: {
                    progressTime = 0
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(Color.gray)
                            .opacity(0.4)
                            .frame(width: 170, height: 100)

                        Image("stop")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                }
            }
        }
    }
}


struct StopwatchUnit: View {

    var timeUnit: Int
    var timeUnitText: String
    

    /// Time unit expressed as String.
    /// - Includes "0" as prefix if this is less than 10.
    var timeUnitStr: String {
        let timeUnitStr = String(timeUnit)
        return timeUnit < 10 ? "0" + timeUnitStr : timeUnitStr
    }

    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Text(timeUnitStr.substring(index: 0))
                        .font(.system(size: 25))
                        //.frame(width: 28)
                    Text(timeUnitStr.substring(index: 1))
                        .font(.system(size: 25))
                        //.frame(width: 28)
                }
            }
        }
    }
}

struct Stopwatch_Previews: PreviewProvider {
    static var previews: some View {
        Stopwatch()
    }
}

extension String {
    func substring(index: Int) -> String {
        let arrayString = Array(self)
        return String(arrayString[index])
    }
}
