//
//  MissionV iew.swift
//  Moonshot
//
//  Created by Manideep Gattamaneni on 1/25/26.
//

import SwiftUI

struct MissionView: View {
    let mission: Mission
    let crew: [CrewMember]
    var body: some View {
        ScrollView {
            VStack {
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { width, axis in
                        width * 0.6
                    }
                    .padding(.top)
                Text(mission.detailedLaunchDate)
            }
            VStack(alignment: .leading) {
                Text("Mission Highlights")
                    .font(.title.bold())
                    .padding(.bottom, 5)
                CustomDivider()

                Text(mission.description)
                
                CustomDivider()
                Text("Crew")
                    .font(.title.bold())
                    .padding(.bottom, 5)
            }
            .padding(.horizontal)
            
            CrewMembersScrollView(crew: crew)
        }.padding(.bottom)
            .navigationTitle(mission.displayName)
            .navigationBarTitleDisplayMode(.inline)
            .background(.darkBackground)
    }

    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }

    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }

        }
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

    return MissionView(mission: missions[0], astronauts: astronauts)
        .preferredColorScheme(.dark)
}
