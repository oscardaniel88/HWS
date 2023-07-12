//
//  ContentView.swift
//  Edutainment2
//
//  Created by Daniel Camarena on 7/11/23.
//

import SwiftUI

struct Question {
    var text: String
    var answer: Int
}

struct AnswerButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 300, height: 100, alignment: .center)
            .background(Color.gray)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
        
    }
}

extension View {
    func drawAnswerButton() -> some View {
        modifier(AnswerButton())
    }
}

struct ContentView: View {
    @State private var multiplicationTable = 2
    @State private var numberOfQuestions = 5
    @State private var gameStarted = false
    @State private var currentQuestion = 0
    @State private var questions = [Question]()
    @State private var answers = [Question]()
    @State private var alertTitle = ""
    @State private var showAlert = false
    @State private var score = 0
    
    var body: some View {
        VStack{
            if !gameStarted{
                VStack {
                    Spacer()
                    Stepper("Multiplication table \(Double(multiplicationTable).formatted())", value:$multiplicationTable, in: 2...12, step:Int.Stride(1.0))
                    Stepper("Number of questions \(Double(numberOfQuestions).formatted())", value:$multiplicationTable, in:5...20, step:Int.Stride(1.0))
                    Spacer()
                    Spacer()
                    Button("Start game"){
                        newGame()
                    }
                    .buttonStyle(.bordered)
                }
            }else{
                VStack{
                    Text("Choose the right answer")
                        .font(.title)
                    Text(questions[currentQuestion].text)
                        .font(.title2)
                    VStack{
                        ForEach(0..<answers.count, id: \.self) {
                            number in
                            Button(action:{
                                checkAnswer(number)
                            })
                            {
                                Text("\(answers[number].answer)")
                                    .foregroundColor(Color.black)
                                    .font(.title3)
                                    .drawAnswerButton()
                                
                            }
                            
                        }
                    }
                    Spacer()
                    Button("End game"){
                        endGame()
                    }
                    .buttonStyle(.bordered)
                }.alert(isPresented: $showAlert) { () -> Alert in
                    Alert(title: Text("\(alertTitle)"), message: Text(" You score is: \(score)"), dismissButton: .default(Text("OK")){
                        return
                    }
                )}
            }
        }
        .padding()
    }
    
    func newGame(){
        gameStarted = true
        createQuestions()
        createAnswers()
    }
    
    func createQuestions(){
        for i in 1 ... numberOfQuestions {
            questions.append(Question(
                text: "\(multiplicationTable) x \(i) = ? ",
                answer: multiplicationTable * i)
            )
        }
        questions.shuffle()
    }
    
    func checkAnswer(_ answer: Int){
        if (answers[answer].answer == questions[currentQuestion].answer){
            score += 1
            alertTitle = "Correct!!!"
        }else{
           alertTitle = "Wrong answer, try again"
        }
        showAlert = true
    }
    
    func createAnswers(){
        answers.append(questions[currentQuestion])
        var questionsCopy = questions
        questionsCopy.remove(at: currentQuestion)
        questionsCopy.shuffle()
        answers.append(questionsCopy[0])
        answers.append(questionsCopy[1])
        answers.append(questionsCopy[2])
    }
    
    func newQuestion() {
        currentQuestion += 1
        answers = []
        createAnswers()
    }
    
    func endGame(){
        gameStarted = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
