/*
 Homework 13
 Name: Nagihan Tokul
 Date: 11/10/2025
 */

//  MemoryGame.swift (Model)

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: FlowerMemoryGame
    @State private var bounce = false
    @State private var colorChange = false

    // Adaptive grid layout
    let columns = [GridItem(.adaptive(minimum: 100))]

    // Progress value comes directly from the model (through ViewModel)
    private var progressFraction: Double { viewModel.progress }

    var body: some View {
        ScrollView {
            VStack {
                // Title text with bounce and color-change animation
                Text("Memory Game")
                    .font(.largeTitle)
                    .foregroundColor(colorChange ? .red : .blue)
                    .bold()
                    .padding(.top)
                    .offset(y: bounce ? -8 : 0)
                    .onTapGesture {
                        withAnimation(.spring(response: 1, dampingFraction: 0.4)) {
                            bounce.toggle()
                            colorChange.toggle()
                        }
                        withAnimation(.spring(response: 0.7, dampingFraction: 0.6).delay(0.3)) {
                            bounce.toggle()
                            colorChange.toggle()
                        }
                    }

                // Progress bar showing matched pairs / total pairs
                ProgressView(value: progressFraction) {
                    Text("Progress")
                } currentValueLabel: {
                    Text("\(Int(progressFraction * 100))%")
                }
                .progressViewStyle(.linear)
                .tint(.blue)
                .animation(.easeInOut, value: progressFraction)
                .padding(.horizontal)

                // Card grid
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                            .aspectRatio(1, contentMode: .fit)
                            .onTapGesture {
                                withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                    viewModel.choose(card)
                                }
                            }
                    }
                }
                .padding()
            }
        }
    }
}

// Card appearance and flip animation
struct CardView: View {
    let card: MemoryGame.Card

    var body: some View {
        ZStack {
            // FRONT SIDE
            Group {
                RoundedRectangle(cornerRadius: 10).fill(.white)
                RoundedRectangle(cornerRadius: 10).stroke(.blue, lineWidth: 3)

                Image(card.content)
                    .resizable()
                    .scaledToFit()
                    .padding(8)

                // Fallback example:
                // Image(systemName: "leaf")
                //     .resizable()
                //     .scaledToFit()
                //     .padding(16)
            }
            .opacity(card.isFaceUp ? 1 : 0)

            // BACK SIDE
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.blue)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.blue, lineWidth: 3)
                )
                .opacity(card.isFaceUp ? 0 : 1)
        }
        // Flip animation
        .rotation3DEffect(.degrees(card.isFaceUp ? 0 : 180),
                          axis: (x: 0, y: 1, z: 0))
        .animation(.easeInOut(duration: 0.4), value: card.isFaceUp)
        .opacity(card.isMatched ? 0.35 : 1.0) // fade out matched cards
        .animation(.easeInOut(duration: 0.3), value: card.isMatched)
        .padding(4)
    }
}

#Preview {
    ContentView(viewModel: FlowerMemoryGame())
}
