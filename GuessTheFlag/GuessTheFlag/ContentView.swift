//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Manideep Gattamaneni on 10/21/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showAlert = false
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State var correctAnswer = Int.random(in: 0...2)
    @State var score = 0
    @State var isAnsweredCorrectly = false
    @State var questionsAnswered = 0
    var body: some View {
        
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)

                VStack(spacing: 15){
                    VStack{
                        Text("Tap the flag of").font(.subheadline.weight(.heavy))
                            .foregroundStyle(.secondary)
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                            Button {
                                flagTapped(number)
                            } label: {
                                Image(countries[number])
                                    .clipShape(.capsule)
                                    .shadow(radius: 5)
                            }
                        }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                Spacer()
                Spacer()
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Spacer()
            }
            .padding()
            
            
        }
        .alert(getScoreTitle(), isPresented: $showAlert) {
            Button("Continue", action: askQuestion)
        } message: {
            getAlertMessage()
        }
    }
    func flagTapped(_ number: Int) {
        isAnsweredCorrectly = number == correctAnswer
        updateScore()
        showAlert = true
    }
    
    func getScoreTitle () -> Text {
        if(isGameOver()){
            return Text("Game Over")
        } else {
            if isAnsweredCorrectly {
                return Text("Correct")
            } else {
                return Text("Wrong!")
            }
        }
    }
    
    func getAlertMessage () -> Text {
        if(isGameOver()){
            return Text("Final Score: \(score).")
        } else{
            if isAnsweredCorrectly {
                return Text("Score: \(score)")
            } else {
                return Text("That was \(countries[correctAnswer]).")
            }
        }
    }
    
    func isGameOver () -> Bool {
        return questionsAnswered >= 7
    }
    func updateQuestionsAnswered() {
         questionsAnswered += 1
    }
    func updateScore() {
        if isAnsweredCorrectly {
            score += 1
        }
    }
    func resetGame() {
        score = 0
        questionsAnswered = 0
        shuffleQuestions()
    }
    func askQuestion() {
        isGameOver() ? resetGame() : updateQuestionsAnswered()
        shuffleQuestions()
        
    }
    func shuffleQuestions() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

#Preview {
    ContentView()
}
