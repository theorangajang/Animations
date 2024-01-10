//
//  SoundBar.swift
//  Animations
//
//  Created by Alex Jang on 1/9/24.
//

import SwiftUI

struct SoundBar: View {
    
    @State private var shouldAlternate: Bool = false
    
    private let colors: [Color] = [.blue, .green, .purple, .cyan, .red]
    
    var body: some View {
        HStack(spacing: 6) {
            ForEach(self.colors, id: \.self) { color in
                RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                    .foregroundStyle(color)
                    .frame(width: 10, height: .random(in: 50...100))
                    .animation(.easeInOut(duration: 0.5), value: self.shouldAlternate)
            }
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
                self.shouldAlternate.toggle()
            }
        }
    }
    
}

#Preview {
    SoundBar()
}
