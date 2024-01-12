//
//  ContentView.swift
//  Animations
//
//  Created by Alex Jang on 1/3/24.
//

import SwiftUI

enum Animations: String, Hashable {
    
    case pendulum = "Pendulum"
    case soundBars = "Sound bars"
    case circleSoundBars = "Circle Sound bar"
    
}

struct ContentView: View {
    
    @State private var animationList: [Animations] = [.pendulum, .soundBars]
    
    var body: some View {
        NavigationStack {
            List(self.animationList, id: \.self) { animation in
                NavigationLink(value: animation) {
                    cell(text: animation.rawValue)
                }
                .navigationDestination(for: Animations.self) { animation in
                    switch animation {
                    case .pendulum:
                        Pendulum()
                    case .soundBars:
                        SoundBar()
                    case .circleSoundBars:
                        CircleSoundBar()
                    }
                }
                .listRowSeparator(.hidden)
                .listRowBackground(self.listBackground)
            }
            .listStyle(.plain)
        }
    }
    
    private var listBackground: some View {
        Color.green
            .clipShape(RoundedRectangle(cornerSize: .init(width: 10, height: 10)))
            .padding(.horizontal, 10)
            .padding(.vertical, 10)
    }
    
    private func cell(text: String) -> some View {
        Text(text)
            .font(.title2)
            .frame(height: 75)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
}

#Preview {
    ContentView()
}
