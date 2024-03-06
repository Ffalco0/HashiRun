//
//  BossBattleView.swift
//  HashiRun
//
//  Created by Fabio Falco on 06/03/24.
//

import SwiftUI


struct BattleResultView: View {
    let result: String
    var onDismiss: () -> Void
    @AppStorage("image", store: UserDefaults(suiteName: "character")) var image: String = "human1"
    
    var body: some View {
        ZStack {
            // Sfondo per la schermata del risultato della battaglia
            Color("background").opacity(0.5).edgesIgnoringSafeArea(.all)
            
            // Visualizzazione del risultato
            VStack {
                Spacer()
                Text(result)
                    .multilineTextAlignment(.center)
                    .font(Font.custom("Press Start", size: 35))
                    .foregroundColor(Color("orangeSlide"))
                    .padding()
                    .cornerRadius(10)
                Spacer()
                if result == "DEFEATED"{
                    Image("skeleton")
                        .resizable()
                        .frame(width: 150, height: 150)
                }else{
                    Image(image)
                        .resizable()
                        .frame(width: 150, height: 150)
                }
                Spacer()
            }
        }
        .onTapGesture {
            onDismiss()
        }
    }
}

#Preview {
    BattleResultView(result: "DEFEATED") {}
}
