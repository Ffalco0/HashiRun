//
//  ChooseCharacter.swift
//  HashiRun
//
//  Created by Fabio Falco on 05/03/24.
//

import SwiftUI

struct ChooseCharacter: View {
    var body: some View {
        let characterImages = ["human1", "human2", "human3"]
        let characterClasses = ["Warrior","Rogue","Mage"]
        
        ZStack {
            Color("background").edgesIgnoringSafeArea(.all)
            
            HStack {
                ForEach(0..<characterImages.count, id: \.self) { index in
                    VStack {
                        Image(characterImages[index])
                            .resizable() // Make the image resizable
                            .scaledToFit() // Keep the image's aspect ratio
                            .frame(width: 100, height: 100)
                        
                        Text(characterClasses[index])
                            .foregroundStyle(.white)
                            .font(Font.custom("Press Start", size: 20))
                            .multilineTextAlignment(.center)
                    }.padding()
                }
            }
        }
    }
}

#Preview {
    ChooseCharacter()
}
