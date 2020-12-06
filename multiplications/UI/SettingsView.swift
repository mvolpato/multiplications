//
//  SettingsView.swift
//  multiplications
//
//  Created by Michele Volpato on 06/12/2020.
//

import SwiftUI

struct SettingsView: View {
    @State private var tables = 2
    @State private var upTo = true
    @State private var numberOfQuestionsPicked = 1

    private var maxQuestions: Int {
        if upTo {
            return tables * 10
        } else {
            return 10
        }
    }

    private var numberOfQuestions : Int {
        if numberOfQuestionsPicked == 1 {
            return 5
        }
        switch numberOfQuestionsPicked {
        case 2:
            if upTo {
                return Int(Double(maxQuestions) * 0.33)
            } else {
                return 3
            }
        case 3:
            if upTo {
                return Int(Double(maxQuestions) * 0.66)
            } else {
                return 7
            }
        default:
            return maxQuestions
        }

    }

    private var explanationText: String {
        let whichTable: String
        if upTo {
            whichTable = "multiplication tables up to \(tables)"
        } else {
            whichTable = "the multiplication table of \(tables)"
        }
        return "You will answer \(numberOfQuestions) questions about \(whichTable)."
    }

    private var bottomView: some View {
        return Group {
            Text(explanationText)
            Spacer()
            NavigationLink(destination: GameView(numberOfQuestions: numberOfQuestions, tables: tables, upTo: upTo)) {
                Text("Start")
            }
            Spacer()
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Stepper("Multiplication table", value: $tables, in: 2...20)
                    Toggle("Include previous tables", isOn: $upTo)
                    Picker(selection: $numberOfQuestionsPicked, label: Text("How many questions?")) {
                        Text("five").tag(1)
                        Text("a few").tag(2)
                        Text("a lot").tag(3)
                        Text("all").tag(4)
                    }
                    .pickerStyle(SegmentedPickerStyle())

                }
                bottomView
            }
            .navigationTitle("Select difficulty")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
