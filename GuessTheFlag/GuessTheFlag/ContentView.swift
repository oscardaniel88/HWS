//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Daniel Camarena on 6/29/23.
//

import SwiftUI

struct ContentView: View {
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var showingFinalAlert = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var count = 0
    var body: some View {
        ZStack{
            RadialGradient(stops:[
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location:0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 700).ignoresSafeArea()
            VStack{
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                VStack(spacing: 15){
                    VStack{
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy)).foregroundStyle(.secondary)
                        Text(countries[correctAnswer]).font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) {number in
                        Button{
                           flagTapped(number)
                        }label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
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
        }.alert(scoreTitle, isPresented: $showingScore){
            Button("Continue", action:askQuestion)
        }message: {
            Text("Your score is \(score)")
        }
        .alert("Finished!", isPresented: $showingFinalAlert){
            Button("OK", action:restart)
        }message:{
            Text("Your score is \(score)")
        }
    }
    
    func flagTapped(_ number: Int){
        count = count + 1
        if number == correctAnswer {
            scoreTitle = "Correct"
            score = score + 1
        }else{
            scoreTitle = "Wrong!! you chosed the flag of \(countries[number])"
            score = score - 1
        }
        showingScore = true
    }
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        if(count == 8){
            showingFinalAlert = true
        }
    }
    
    func restart(){
        score = 0
        count = 0
        askQuestion()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
