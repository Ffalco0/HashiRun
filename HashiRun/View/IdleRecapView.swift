//
//  IdleRecapView.swift
//  HashiRun
//
//  Created by Fabio Falco on 29/02/24.
//

import SwiftUI



struct IdleRecapView: View {
    let eventsGenerator = EventsGenerator()
    @State private var displayEvents: [Event] = []
    @State private var timer: Timer?
    var body: some View {
        ScrollView{
            VStack{
                ForEach(displayEvents, id: \.id) { event in
                    VStack{
                        Text("\(event.name)")
                            .font(Font.custom("Press Start", size: 15))
                        Text("\(event.description)")
                            .font(Font.custom("Press Start", size: 12))
                            .multilineTextAlignment(.center)
                        Image("\(event.collectible)")
                    }
                    .padding()
                }
            }
        }
           .onAppear {
               // Initialize and schedule the timer
               timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { _ in
                   if let event = eventsGenerator.generateRandomEvent() {
                       // Update state variables to refresh the view
                       displayEvents.append(event)
                   }
               }
           }
        Button(action: {
            timer?.invalidate()
        }, label: {
            Text("Button")
        })
    }
}

#Preview {
    IdleRecapView()
}
