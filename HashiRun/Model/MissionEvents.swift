//
//  MissionEvents.swift
//  HashiRun
//
//  Created by Fabio Falco on 29/02/24.
//

import Foundation

// Define a structure to represent an event
struct Event {
    let id = UUID() // Adding Identifiable conformance
    let name: String
    let description: String
    let collectible: String
}

// Define a class to manage the random events generator
class EventsGenerator {
    
    let events: [(Event, Double)] = [
        (Event(name: "Raiders Attack", description: "Your shelter is attacked by raiders!",collectible: ""), 0.1),
        (Event(name: "Resource Scarcity", description: "Resources are running low!",collectible: ""), 0.2),
        (Event(name: "Newcomer Arrives", description: "A new survivor arrives at your shelter.",collectible: ""), 0.3),
        (Event(name: "You found a Sword!", description: "While you are tripping in to the woods you see a strange shine and it is a sword",collectible: "bow"), 0.6),
        // Add more events with their probabilities
    ]
    
    // Method to generate a random event
    func generateRandomEvent() -> Event? {
        let randomNumber = Double.random(in: 0..<1) // Generate a random number between 0 and 1
        var cumulativeProbability = 0.0
        
        for (event, probability) in events {
            cumulativeProbability += probability
            if randomNumber < cumulativeProbability {
                return event // Return the event if the random number falls within its probability range
            }
        }
        
        return nil // Return nil if no event is selected (shouldn't happen if probabilities sum up to 1)
    }
}
