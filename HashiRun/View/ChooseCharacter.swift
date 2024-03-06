//
//  ChooseCharacter.swift
//  HashiRun
//
//  Created by Fabio Falco on 05/03/24.
//

import SwiftUI

struct ChooseCharacter: View {
    
    var body: some View {
        let characterImages = ["warrior11", "rogue11", "mage11"]
        let characterClasses = ["Warrior","Rogue","Mage"]
        @AppStorage("image", store: UserDefaults(suiteName: "character")) var image: String = "human"
        @AppStorage("firstCompletation", store: UserDefaults(suiteName: "character")) var firstCompletation: Bool = false
        @State var rememberSelection: Int? = nil
        
        NavigationStack{
            ZStack {
                Color("background").edgesIgnoringSafeArea(.all)
                VStack{
                    Text("Choose your Hero")
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                        .font(Font.custom("Press Start", size: 30))
                    
                    Spacer()
                    TabView{
                         ScrollView(.horizontal, showsIndicators: false){
                             HStack(spacing: 15){
                                 Spacer()
                                 ForEach(0..<characterImages.count, id: \.self) { index in
                                     NavigationLink(destination: CharacterView()){
                                         VStack{
                                             ZStack{
                                                 Circle()
                                                     .foregroundStyle(.gray)
                                                     .frame(width: 300)
                                                     .opacity(0.25)
                                                 
                                                 Image(characterImages[index])
                                                     .resizable()
                                                     .scaledToFit()
                                                     .frame(width: 200, height: 200)
                                             }
                                             .padding()
                                             Text(characterClasses[index])
                                                 .foregroundStyle(.white)
                                                 .font(Font.custom("Press Start", size: 30))
                                                 .multilineTextAlignment(.center)
                                             
                                         }
                                         .tag(index)
                                         .padding()
                                         .onTapGesture {
                                             firstCompletation = true
                                             image = characterImages[index]
                                         }
                                     }
                                 }.scrollTargetLayout()
                                 Spacer()
                             }
                         }.scrollTargetBehavior(.paging)
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                    .indexViewStyle(.page(backgroundDisplayMode: .always))
                    
                    Spacer()
                    
                    Text("This choice will be permanent!!")
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                        .font(Font.custom("Press Start", size: 30))
                }
            }.navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    ChooseCharacter()
}


