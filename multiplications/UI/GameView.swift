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

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(numberOfQuestions: 5, tables: 5, upTo: true)
    }
}
