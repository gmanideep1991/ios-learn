//
//  ContentView.swift
//  Moonshot
//
//  Created by Manideep Gattamaneni on 1/21/26.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    @State private var showAsList = false
    var body: some View {
        NavigationStack{
            ScrollView{
                Group{
                    if showAsList{
                        MissionListView(astronauts: astronauts, missions: missions)
                    } else {
                        MissionGridView(astronauts: astronauts,missions: missions)
                    }
                }
            }.navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("Toggle View", systemImage: showAsList ? "square.grid.3x3": "list.bullet"){
                        showAsList.toggle()
                    }
                }
            }
        }
        
    }
}

#Preview {
    ContentView()
}
