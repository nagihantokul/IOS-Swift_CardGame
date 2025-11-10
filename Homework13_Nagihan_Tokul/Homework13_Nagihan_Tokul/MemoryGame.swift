/*
 Homework 13
 Name: Nagihan Tokul
 Date: 11/10/2025
 */

//  MemoryGame.swift (Model)



import Foundation

struct MemoryGame {

    private(set) var cards: [Card]
    private(set) var numberOfPairs: Int

    private(set) var matchedPairsCount: Int = 0

    var progress: Double {
        guard numberOfPairs > 0 else { return 0 }
        return Double(matchedPairsCount) / Double(numberOfPairs)
    }

    struct Card: Identifiable {
        var content: String
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var id: Int
    }

    mutating func chooseCard(_ card: Card) {
        guard let tappedIndex = cards.firstIndex(where: { $0.id == card.id }),
              !cards[tappedIndex].isMatched else { return }

        // Close two open unmatched before flipping a third
        let openUnmatched = cards.indices.filter { cards[$0].isFaceUp && !cards[$0].isMatched }
        if openUnmatched.count == 2 {
            for i in openUnmatched { cards[i].isFaceUp = false }
        }

        // Flip tapped
        cards[tappedIndex].isFaceUp.toggle()

        // Check exactly two face-up unmatched
        let faceUpIndices = cards.indices.filter { cards[$0].isFaceUp && !cards[$0].isMatched }
        if faceUpIndices.count == 2 {
            let first = faceUpIndices[0]
            let second = faceUpIndices[1]
            if cards[first].content == cards[second].content {
                cards[first].isMatched = true
                cards[second].isMatched = true
                // 🔹 NEW: increment matched pairs in the MODEL
                matchedPairsCount += 1
            }
        }
    }

    init(numberOfPairsOfCards: Int, contentFactory: (Int) -> String) {
        self.cards = []
        self.numberOfPairs = numberOfPairsOfCards

        for index in 0..<numberOfPairsOfCards {
            let content = contentFactory(index)
            cards.append(Card(content: content, id: index * 2))
            cards.append(Card(content: content, id: index * 2 + 1))
        }
        cards.shuffle()
    }
}
