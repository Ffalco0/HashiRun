//
//  ChooseCharacter.swift
//  HashiRun
//
//  Created by Fabio Falco on 05/03/24.
//

import SwiftUI

struct ChooseCharacter: View {
    var body: some View {
        let characterImages = ["image 8pg", "ladroliv1 1pg", "magelvl1 1pg"]
        let characterClasses = ["Warrior","Rogue","Mage"]
        @AppStorage("image", store: UserDefaults(suiteName: "character")) var image: String = "human3"
        @State var rememberSelection: Int? = nil
        
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
                    }
                    .padding()
                    .onTapGesture {
                       image = characterImages[index]
                    }
                }
            }
        }
    }
}

#Preview {
    ChooseCharacter()
}
