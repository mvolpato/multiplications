//
//  GameView.swift
//  multiplications
//
//  Created by Michele Volpato on 06/12/2020.
//

import SwiftUI

struct GameView: View {
    let numberOfQuestions: Int
    let tables: Int
    let upTo: Bool

    private var questions: [Question]

    init(numberOfQuestions: Int, tables: Int, upTo: Bool) {
        self.numberOfQuestions = numberOfQuestions
        self.tables = tables
        self.upTo = upTo

        var buildQuestions: [Question] = []
        let startingTable = upTo ? 1 : tables
        for factor1 in startingTable...tables {
            for factor2 in 1...10 {
                buildQuestions.append(Question(firstFactor: factor1, secondFactor: factor2))
                if buildQuestions.count == numberOfQuestions {
                    break
                }
            }
        }
        questions = buildQuestions
    }

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var answer = "0"
    @State private var score = 0
    @State private var currentQuestion = 0
    @State private var showingFinalAlert = false

    private func answerButton(number: Int) -> some View {
        return Button (action: {
            if self.answer.count < 3 {
                self.answer += "\(number)"
            }
            if self.answer.starts(with: "0") {
                self.answer = String(self.answer.dropFirst())
            }
        }) {
            Image(systemName: "\(number).circle")
        }
    }

    var body: some View {
        VStack {
            Text(questions[currentQuestion].text)
            Spacer()
            Text("Your answer")
                .font(.title)
            Text("\(answer)")
                .font(.title)
            Group {
                ForEach(0..<3) { row in
                    HStack {
                        ForEach(0..<3) { column in
                            answerButton(number: (row * 3) + (column) + 1)
                        }
                    }
                }
                HStack {
                    Button (action: {
                        self.answer = "0"
                    }) {
                        Image(systemName: "xmark.circle")
                    }
                    answerButton(number: 0)
                    Button (action: {
                        self.answer = String(self.answer.dropLast())
                        if self.answer.count == 0 {
                            self.answer = "0"
                        }
                    }) {
                        Image(systemName: "minus.circle")
                    }
                }
            }
            .font(.custom("System", fixedSize: 60))
            Spacer()
            Button (action: {
                submitTapped()
            }) {
                Text("Submit")
            }
            Spacer()
            Text("Your score: \(score)")
                .alert(isPresented: $showingFinalAlert) {
                    Alert(title: Text("Game over"), message: Text("Your score is \(score)"), dismissButton: .default(Text("Back to start")) {
                        presentationMode.wrappedValue.dismiss()
                    })
                }
        }
    }

    func submitTapped() {
        if let answerInt = Int(answer) {
            if answerInt == questions[currentQuestion].result {
                score += 1
            } else {
                score -= 1
            }
        } else {
            fatalError("Answer is not a number?")
        }

        if currentQuestion < (numberOfQuestions - 1) {
            currentQuestion += 1
            answer = "0"
        } else {
            showingFinalAlert = true
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(numberOfQuestions: 5, tables: 5, upTo: true)
    }
}
