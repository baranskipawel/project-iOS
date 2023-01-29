//
//  ContentView.swift
//  Project-2-Flags
//
//  Created by Pawel Baranski on 05/01/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var score = 0
    @State private var questionCounter = 0
    @State private var shwoingResults = false
    
    @State private var animationAmount = 0.0
    
    @State private var animateOpacity = 1.0
    @State private var besidesTheCorrect = false
    @State private var besidesTheWrong = false
    
    @State private var isCorrectAnserw = -1

    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)

    var body: some View {
        ZStack {
            
            VStack {
                Spacer()

                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.black)

                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))

                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }

                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(country: countries[number])
                        }.rotation3DEffect(.degrees(isCorrectAnserw == number ? 360 : 0), axis: (x: 0, y: 1, z: 0))
                            .opacity(isCorrectAnserw == -1 || isCorrectAnserw == number ? 1 : 0.25)
                            .scaleEffect(isCorrectAnserw == -1 || isCorrectAnserw == number ? 1 : 0.5)
                            .rotationEffect(.degrees(isCorrectAnserw == -1 || isCorrectAnserw == number ? 0 : 360))
                            .animation(.default, value: isCorrectAnserw)
                            
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))

                Spacer()
                Spacer()

                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())

                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
            
        } message: {
            Text("Your score is: \(score)")
        }
        .alert("Game over!", isPresented: $shwoingResults){
            Button("GO next", action: newGame)
        } message: {
            Text("Your final score is: \(score)")
        }
    }

    func flagTapped(_ number: Int) {
        
        isCorrectAnserw = number
        
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            
            withAnimation {
                self.animationAmount += 360
                self.animateOpacity = 0.25
                self.besidesTheCorrect = true
            }
            
        } else {
            let userAnserw = countries[number]
            
            scoreTitle = "Wrong! That's a flag of \(userAnserw). -1 point"
            
            withAnimation {
                self.animateOpacity = 0.25
                self.besidesTheWrong = true
            
            }
                        
            if score > 0 {
                score -= 1
            }
        }

        showingScore = true
        
        if questionCounter == 8 {
            shwoingResults = true
        }
        else{
            showingScore = true
        }
    }

    func askQuestion() {
        besidesTheCorrect = false
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        questionCounter+=1
        isCorrectAnserw = -1
    }
    
    func newGame(){
            questionCounter = 0
            score = 0
            countries = self.countries
            askQuestion()
        }
}

struct FlagImage : View {
    
    let country : String
    
    var body: some View{
        Image(country)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
