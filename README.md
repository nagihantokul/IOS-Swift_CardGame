# Memory Game with ProgressView  
**Name:** Nagihan Tokul  
**Course:** CIS 137 – SwiftUI Development  
**Assignment:** Homework 13 – ProgressView Integration  

---

## Objective  
The purpose of this project is to integrate a `ProgressView` into the existing **Memory Game** app.  
The progress bar updates automatically as the player matches pairs of cards.  
When half of the pairs are matched, the bar shows 50% progress; when all are matched, it reaches 100%.

---

## Features  
- Real-time `ProgressView` that updates as the user matches pairs  
- Animated 3D card flip effect using `rotation3DEffect`  
- Smooth UI transitions with `withAnimation`  
- Adaptive grid layout that works on all screen sizes  
- Fade-out animation for matched cards  
- Bounce and color-change animation on the title text  

---

##  How ProgressView Works  
- The **Model (`MemoryGame.swift`)** tracks matched pairs using `matchedPairsCount` and calculates overall `progress` (a value between 0.0 and 1.0).  
- The **ViewModel (`FlowerMemoryGame.swift`)** exposes `var progress: Double { model.progress }` for the view.  
- The **View (`ContentView.swift`)** uses `ProgressView(value: viewModel.progress)` so it reacts automatically when the model updates.

---

##  How to Run  
1. Open the project in **Xcode** (version 15 or later).  
2. Choose an iPhone simulator (for example, iPhone 15 Pro).  
3. Press **Run**.  
4. Tap the cards to play.  
   The `ProgressView` will fill up as you match more pairs.

---

##  Demo Video  
A short screen recording is included to show the progress feature in action.  
