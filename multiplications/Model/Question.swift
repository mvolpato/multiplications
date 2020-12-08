//
//  Question.swift
//  multiplications
//
//  Created by Michele Volpato on 08/12/2020.
//

import Foundation

struct Question {
    let firstFactor: Int
    let secondFactor: Int

    var result: Int {
        firstFactor * secondFactor
    }

    var text: String {
        "What is \(firstFactor) x \(secondFactor)?"
    }
}
