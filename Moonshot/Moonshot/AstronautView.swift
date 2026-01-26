//
//  AstronautView.swift
//  Moonshot
//
//  Created by Manideep Gattamaneni on 1/25/26.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut

        var body: some View {
            ScrollView {
                VStack {
                    Image(astronaut.id)
                        .resizable()
                        .scaledToFit()

                    Text(astronaut.description)
                        .padding()
                }
            }
            .background(.darkBackground)
            .navigationTitle(astronaut.name)
            .navigationBarTitleDisplayMode(.inline)
        }
}

#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

        return AstronautView(astronaut: astronauts["aldrin"]!)
            .preferredColorScheme(.dark)
}
