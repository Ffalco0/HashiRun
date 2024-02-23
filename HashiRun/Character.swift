//
//  Character.swift
//  HashiRun
//
//  Created by Fabio Falco on 23/02/24.
//

import SwiftUI


struct CollectiblesView: View {
    let images: [String] // Array of image names
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 3), spacing: 10) {
                ForEach(images, id: \.self) { imageName in
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 80) // Adjust the frame size as needed
                }
            }
            .padding()
        }
    }
}
struct SkillTable: View {
    var skills: [String]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 1), spacing: 20) {
                ForEach(skills, id: \.self) { skill in
                    HStack {
                        Text(skill)
                            .font(.title2)
                        Text("0")
                            .font(.title2)
                    }
                }
            }
            .padding()
        }
    }
}

struct CustomProgressBar: View {
    let progress: CGFloat
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


struct CharacterView: View {
    @State private var progressValue: Double = 0 // Initial progress value
    @State private var level = 1
    @State private var skillPoint = 0
    @State private var skillValue: [CGFloat] = [0,0,0]
    
  
    private var skills: [String] = ["Strenght","Dex","Wisdom"]
    
    var body: some View {
        NavigationStack{
            ScrollView {
                VStack{
                    //MARK: - Character section
                    Section {
                        Image("wizard")
                            .resizable()
                            .frame(width: 200.0, height: 250.0)
                            .clipShape(.rect)
                        
                        
                        
                        //MARK: - Level section
                        HStack (alignment: .center){
                            Text("Lvl \(level)")
                                .font(.title3)
                                .fontWeight(.bold)
                                .padding()
                            
                            //Start working on the progress bar
                            CustomProgressBar(progress: progressValue, imageName: "back")
                                .padding()
                        }.padding()
                        
                        //Tester to check if the lvl increment when you complete the bar
                        Button("Increase Progress") {
                            
                            if progressValue < 0.9{
                                withAnimation(.linear(duration: 0.2)) {
                                    //progressValue += 0.1 // Increase progress value
                                    
                                }
                                
                            }else{
                                progressValue = 0
                                level += 1
                                skillPoint += 1
                            }
                        }
                        Spacer()
                        //MARK: - Statistic section
                        
                        VStack {
                            HStack {
                                Text("Skill")
                                    .font(Font.custom("prstart", size: 50))
                                    .padding(.horizontal)
                                Spacer()
                                
                                
                            }
                            SkillTable(skills: ["Strenght","Dextry","Wisdom"])
                        }
                    }
                    Divider()
                        .frame(height: 20)
                    Section{
                        //MARK: - Collectibles section
                        HStack {
                            Text("Collectibles")
                                .font(.title)
                                .padding()
                                .fontWeight(.bold)
                            Spacer()
                        }
                        
                        CollectiblesView(images: ["image1", "image2", "image3", "image4"])
                        Spacer()
                    }
                    
                    
                }
            }
            .navigationTitle("The knight")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    HStack {
                        Text("\(skillPoint)")
                        Image(systemName: "gear")
                    }
                }
            }
            
        }
        
        
        
    }
}

#Preview {
    CharacterView()
}
