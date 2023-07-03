//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Daniel Camarena on 7/3/23.
//

import SwiftUI

struct ContentView: View {
    @State var cpuSelection = Int.random(in: 0...2)
    var cpuOptions = ["Rock", "Paper", "Scissors"]
    var cpuPrompt = ["Win", "Loose"]
    @State var cpuPromptSelected = Int.random(in: 0...1)
    @State var score = 0
    @State var showingAlert = false
    @State var count = 0
    var body: some View {
        NavigationView{
            VStack(spacing: 15){
                Text("CPU selected \(cpuOptions[cpuSelection])")
                Text("CPU wants you to \(cpuPrompt[cpuPromptSelected])")
                HStack{
                    ForEach (cpuOptions, id: \.self){option in
                        Button{
                            verify(option: option)
                            select()
                        }label: {
                            Text(option)
                        }.disabled(option.elementsEqual(cpuOptions[cpuSelection]))
                    }
                }
                Text("Player 1 score = \(score)")
            }.alert("Finished!", isPresented: $showingAlert){
                Button("OK", action:restart)
            }message:{
                Text("Your score is \(score)")
            }
            .padding()
            .navigationTitle("Rock Paper Scissors")
        }
    }
    func select(){
        cpuSelection = Int.random(in: 0...2)
        cpuPromptSelected = Int.random(in: 0...1)
    }
    
    func restart(){
        score = 0
        count = 0
        select()
    }
    
    func verify (option: String){
        let askedToWin = cpuPrompt[cpuPromptSelected].elementsEqual("Win")
        let winningMove = winningMoveFor(option:cpuOptions[cpuSelection])
        let didWin = option.elementsEqual(winningMove)
        if(didWin && askedToWin){
            score = score + 1
        }
        if(!didWin && !askedToWin){
            score = score + 1
        }
        count = count + 1
        if (count == 10){
            showingAlert = true
        }
    }
    
    func winningMoveFor(option:String) -> String {
        if(option == "Rock"){
            return "Paper"
        }
        if(option == "Paper"){
            return "Scissors"
        }
        if(option == "Scissors"){
            return "Rock"
        }
        return ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
