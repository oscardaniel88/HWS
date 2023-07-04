//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Daniel Camarena on 7/3/23.
//

import SwiftUI

struct ContentView: View {
    @State var cpuSelection = Int.random(in: 0...2)
    var cpuOptions = ["🪨", "📃", "✂️"]
    var cpuPrompt = ["Win", "Loose"]
    @State var cpuPromptSelected = Int.random(in: 0...1)
    @State var score = 0
    @State var showingAlert = false
    @State var count = 0
    var body: some View {
        NavigationView{
            ZStack{
                LinearGradient(colors: [.red, .yellow], startPoint:.top, endPoint: .bottom).ignoresSafeArea()
                VStack(spacing: 30){
                    Text("CPU selected \(cpuOptions[cpuSelection])")
                        .font(.title)
                    Text("CPU wants you to \(cpuPrompt[cpuPromptSelected])")
                        .font(.title)
                    HStack(spacing: 45){
                        ForEach (cpuOptions, id: \.self){option in
                            Button{
                                verify(option: option)
                                select()
                            }label: {
                                Text(option)
                                    .font(.largeTitle)
                            }.disabled(option.elementsEqual(cpuOptions[cpuSelection]))
                                .buttonStyle(.plain)
                        }
                    }
                    Text("Player 1 score = \(score)")
                        .font(.title3)
                }.alert("Finished!", isPresented: $showingAlert){
                    Button("OK", action:restart)
                }message:{
                    Text("Your score is \(score)")
                }
                .padding()
            }
        }
    }
    func select(){
        cpuSelection = Int.random(in: 0...2)
        cpuPromptSelected = Int.random(in: 0...1)
    }
    
    func restart(){//
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
        if(option == "🪨"){
            return "📃"
        }
        if(option == "📃"){
            return "✂️"
        }
        if(option == "✂️"){
            return "🪨"
        }
        return ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
