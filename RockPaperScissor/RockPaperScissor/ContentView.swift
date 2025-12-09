//
//  ContentView.swift
//  RockPaperScissor
//
//  Created by Manideep Gattamaneni on 12/9/25.
//

import SwiftUI

struct ContentView: View {
    @State private var shouldWin = Bool.random()
    @State private var appChoice = moves.allCases.randomElement()
    @State private var score: Int = 0
    @State private var game: Int = 0
    @State private var showFinalScore: Bool = false
    
    enum moves: String, CaseIterable {
        case rock="🪨",paper="📄",scissor="✂️"
    }
    
    func getCorrectMove() -> moves? {
        switch appChoice {
        case .rock:
            shouldWin ? .paper : .scissor
        case .paper:
            shouldWin ? .rock : .scissor
        case .scissor:
            shouldWin ? .paper : .rock
        case .none:  nil
        }
    }
    
    func moveTapped(_ move: moves){
        if(getCorrectMove() == move){
            score = score+1
        }
        if(game == 10){
            showFinalScore = true
        }else{
            game = game+1
            appChoice = moves.allCases.randomElement()
            shouldWin.toggle()
        }
    }
    
    func reset() {
        game = 1
        score = 0
        shouldWin = Bool.random()
        appChoice = moves.allCases.randomElement()
        
    }
    
    
    var body: some View {
        VStack {
            VStack{
                Text("Computer choice")
                Text(appChoice!.rawValue).font(.system(size: 50))
                Text("Player's should select \(shouldWin ? "Win" : "Lose") move!")
            }
            HStack {
                ForEach(moves.allCases, id:\.rawValue){ move in
                    Spacer()
                    Button(move.rawValue){
                        moveTapped(move)
                    }.buttonStyle(.bordered).font(.system(size: 50))
                    Spacer()
                }
                
            }
            HStack{
                Spacer()
                Text("game: \(game) \\ 10")
                Spacer()
                Text("score: \(score)")
                Spacer()
            }
        }.alert("End Game",isPresented: $showFinalScore){
            Button("Reset", action:reset)
        } message: {
            Text("Your final score is \(score)")
        }
    }
}

#Preview {
    ContentView()
}
