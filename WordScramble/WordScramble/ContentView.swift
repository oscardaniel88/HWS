//
//  ContentView.swift
//  WordScramble
//
//  Created by Daniel Camarena on 7/6/23.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var score = 0.0
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        NavigationView {
            Form{
                Section {
                    TextField("Type your word", text:$newWord)
                        .textInputAutocapitalization(.never)
                }header:{
                    HStack{
                        Text("Score")
                        Text("\(score.formatted())")
                    }
                    
                }
                Section ("Answers"){
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showingError){
                Button("OK", role: .cancel) {}
            } message: {
                Text(errorMessage)
            }
            .toolbar{
                Button("Restart"){
                    startGame()
                }
            }
        }
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 3 && answer != rootWord else {
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "You already used that word", message:"Try something different")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word is not possible", message: "You can't spell that word from '\(rootWord)'!")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        withAnimation{
            usedWords.insert(answer, at:0)
        }
        score = score + Double(answer.count) * 1.25
        newWord = ""
    }
    func restartGame(){
        startGame()
        usedWords = [String]()
        score = 0
    }
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: ".txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy:"\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        fatalError("Could not load resources from bundle.")
    }
    
    func isOriginal (word: String) -> Bool {
        return !usedWords.contains(word)
    }
    
    func isPossible (word: String) -> Bool {
        var tempWord = rootWord
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter){
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal (word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
