//
//  ContentView.swift
//  Project-8-Moonshot
//
//  Created by Student1 on 11/01/2023.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var showingGrid = true;

    var body: some View {
        
        NavigationView{
            Group{
                if showingGrid {
                    GridLayout(astronauts: astronauts, missions: missions)
                }
                else{
                    ListLayout(astronauts: astronauts, missions: missions)
                }
            }.navigationTitle("Moonlight").toolbar{
                Button("Change view"){
                    showingGrid.toggle()
                }
            }
        }
        
    }
    
    func flipView () {
        showingGrid.toggle()
    }
}

struct ListLayout : View {
    
    let astronauts : [String:Astronaut]
    let missions: [Mission]
    
    var body: some View {
            NavigationView {
                List(missions) { mission in
                    NavigationLink(
                        destination: MissionView(mission: mission, astronauts: self.astronauts)) {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 44, height: 44)
                        
                        VStack(alignment: .leading){
                            Text(mission.displayName)
                                .font(.headline)
                            Text(mission.formattedLaunchDate)
                        }
                    }
                    
                }
                .background(.darkBackground)
                .preferredColorScheme(.dark)
            }
        }
}

struct GridLayout : View {
    
    let astronauts : [String:Astronaut]
    let missions: [Mission]
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body : some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(missions) { mission in
                        NavigationLink {
                            MissionView(mission: mission, astronauts: astronauts)
                        } label: {
                            VStack {
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .padding()

                                VStack {
                                    Text(mission.displayName)
                                        .font(.headline)
                                        .foregroundColor(.white)

                                    Text(mission.formattedLaunchDate)
                                        .font(.caption)
                                        .foregroundColor(.white.opacity(0.5))
                                }
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(.lightBackground)
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.lightBackground)
                            )
                        }
                    }
                }
                .padding([.horizontal, .bottom])
            }
            .background(.darkBackground)
            .preferredColorScheme(.dark)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
