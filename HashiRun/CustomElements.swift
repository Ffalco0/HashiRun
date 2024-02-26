//
//  CustomElements.swift
//  HashiRun
//
//  Created by Fabio Falco on 26/02/24.
//

import Foundation
import SwiftUI

struct CustomDivider: View {
    var textToDisplay:String
    var body: some View {
        HStack{
            VStack { Divider().background(Color.gray) }
            Text(textToDisplay)
                .multilineTextAlignment(.center)
                .font(.custom("Press Start", size: 10))
                .foregroundColor(.gray)
                .padding(.horizontal, 8)
            VStack { Divider().background(Color.gray) }
        }
    }
}


struct CollectiblesView: View {
    let images: [String] // Array of image names
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 3), spacing: 10) {
                ForEach(images, id: \.self) { imageName in
                    ZStack{
                        Capsule()
                            .foregroundStyle(Color.gray.opacity(0.5))
                            .frame(width: 80, height: 80) // Adjust the frame size as needed
                        
                        Image(imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50) // Adjust the frame size as needed
                    }
                }
            }
            .padding()
        }
    }
}
struct CustomProgressBar: View {
    var progress: Double
    let imageName: String
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                
                RoundedRectangle(cornerRadius: 20)
                     .frame(width: geometry.size.width, height: 20)
                     .opacity(0.3)
                     .foregroundColor(.gray)
                
               Rectangle()
                    .frame(
                        width: min(progress * geometry.size.width,
                                   geometry.size.width),
                        height: 20
                    )
                    .background(LinearGradient(gradient: Gradient(colors: [ Color("fill")
                        .opacity(0.1),Color("fill").opacity(1.0)]), startPoint: .top, endPoint: .bottom)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    )
                    .foregroundColor(.clear)
            }
        }
    }
}


