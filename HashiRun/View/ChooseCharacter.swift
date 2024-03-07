//
//  ChooseCharacter.swift
//  HashiRun
//
//  Created by Fabio Falco on 05/03/24.
//

import SwiftUI

struct ChooseCharacter: View {
    @State var characterSelected: Bool = false

    var body: some View {
        let characterImages = ["warrior11", "rogue11", "mage11"]
        let characterClasses = ["Warrior","Rogue","Mage"]
        @AppStorage("image", store: UserDefaults(suiteName: "character")) var image: String = "human"
        @AppStorage("choosedCharacter", store: UserDefaults(suiteName: "character")) var choosedCharacter: Bool = false
        
        @State var rememberSelection: Int? = nil
        
        NavigationStack{
            ZStack {
                Color("background").edgesIgnoringSafeArea(.all)
                VStack{
                    Spacer()
                    Text("Choose your Hero")
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                        .font(Font.custom("Press Start", size: 30))
                    
                    HStack{
                        Spacer()
                        TabView{
                            ForEach(0..<characterImages.count, id: \.self) { index in
                                
                                Button(action: {
                                    image = characterImages[index]
                                    characterSelected.toggle()
                                    choosedCharacter = false
                                    print(image)
                                    print(characterSelected)
                                }, label: {
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
                                    .padding()
                                    .navigationDestination(isPresented: $characterSelected){HomePage()}

                                }
                                )
                                
                            }
                            
                            
                        }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                        .indexViewStyle(.page(backgroundDisplayMode: .always))
                        
                    }
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


