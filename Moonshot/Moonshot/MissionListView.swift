//
//  MissionListView.swift
//  Moonshot
//
//  Created by Manideep Gattamaneni on 1/25/26.
//

import SwiftUI

struct MissionListView: View {
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    var body: some View {
        
                LazyVStack{
                    ForEach(missions) { mission in
                        NavigationLink(value: mission){
                            HStack{
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .padding()
                                
                                VStack{
                                    Text(mission.displayName).font(.headline).foregroundStyle(.white)
                                    Text(mission.formattedLaunchDate).font(.caption).foregroundStyle(.white.opacity(0.5))
                                }.padding()
                                
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(.lightBackground)
                                Image(systemName: "chevron.right").padding(.trailing)
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
    MissionListView(astronauts: astronauts, missions: missions)
}
