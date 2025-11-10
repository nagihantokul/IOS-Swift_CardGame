/*
 Homework 13
 Name: Nagihan Tokul
 Date: 11/10/2025
 */


//  FlowerMemoryGame.swift (ViewModel)


import SwiftUI
import Combine

class FlowerMemoryGame: ObservableObject {
    @Published private var model: MemoryGame = FlowerMemoryGame.createMemoryGame()

    private static func createMemoryGame() -> MemoryGame {
        MemoryGame(numberOfPairsOfCards: 6, contentFactory: makeContent)
    }

    private static func makeContent(index: Int) -> String {
        let images = [
            "flower1","flower2","flower3","flower4","flower5","flower6",
            "flower7","flower8","flower9","flower10","flower11","flower12"
        ]
        return images[index % images.count]
    }

    var cards: [MemoryGame.Card] { model.cards }
    var pairs: Int { model.numberOfPairs }

    var progress: Double { model.progress }

    func choose(_ card: MemoryGame.Card) {
        withAnimation(.easeInOut(duration: 0.5)) {
            model.chooseCard(card)
        }
    }
}
