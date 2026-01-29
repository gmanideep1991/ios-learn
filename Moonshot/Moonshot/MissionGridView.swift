//
//  MissionGridView.swift
//  Moonshot
//
//  Created by Manideep Gattamaneni on 1/25/26.
//

import SwiftUI

struct MissionGridView: View {
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    var body: some View {
        let columns = [
            GridItem(.adaptive(minimum: 150))
        ]
        
                LazyVGrid(columns: columns){
                    ForEach(missions) { mission in
                        NavigationLink(value: mission){
                            VStack{
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .padding()
                                VStack{
                                    Text(mission.displayName).font(.headline).foregroundStyle(.white)
                                    Text(mission.formattedLaunchDate).font(.caption).foregroundStyle(.white.opacity(0.5))
                                }
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(.lightBackground)
                            }
                            .clipShape(.rect(cornerRadius: 10))
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(.lightBackground))
                        }
                    }
                }.padding([.horizontal, .bottom])
            .navigationDestination(for: Mission.self){mission in
                MissionView(mission: mission, astronauts: astronauts)
            }
            
    }
}

#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    MissionGridView(astronauts: astronauts, missions: missions)
}
