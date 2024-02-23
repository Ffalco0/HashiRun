//
//  ContentView.swift
//  HashiRun
//
//  Created by Fabio Falco on 23/02/24.
//

import SwiftUI

struct HomePage: View {
    var body: some View {
        NavigationStack{
            VStack{
                //tryng pull content frorm git
                NavigationLink(destination: CharacterView()) {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width:300,height: 400)
                        .foregroundColor(.clear)
                        .background(
                            Image("bg")
                                .resizable()
                                .scaledToFit()
                    )
                }
                
                Spacer()
                Button(action: {
                    print("See mission 01")
                }, label: {
                    Text("Mission 01")
                })
                Button(action: {
                    print("See mission 01")
                }, label: {
                    Text("Mission 01")
                })
            }
        }
    }
}

#Preview {
    HomePage()
}
