//
//  Pendulum.swift
//  Animations
//
//  Created by Alex Jang on 1/9/24.
//

import SwiftUI

private enum RotationState: Int {
    
    case max
    case min
    
}

struct Pendulum: View {
    
    private static let degrees: Double = 45
    private static let holderSize: CGSize = CGSize(width: 16, height: 16)
    
    @State private var rotationState: RotationState = .min
    
    var body: some View {
        VStack(spacing: .zero) {
            self.holder
            ZStack {
                swing(
                    text: "Hello",
                    degrees: self.rotationState == .max ? -Self.degrees : Self.degrees
                )
                swing(
                    text: "World",
                    degrees: self.rotationState == .max ? Self.degrees : -Self.degrees
                )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .onAppear(perform: setRotationState)
    }
    
    private var holder: some View {
        Circle()
            .foregroundStyle(.red)
            .frame(
                width: Self.holderSize.width,
                height: Self.holderSize.height
            )
    }
    
    private func swing(text: String, degrees: Double) -> some View {
        VStack(spacing: .zero) {
            Rectangle()
                .frame(width: 1, height: 200)
            Text(text)
                .padding(Padding.small)
                .background(Color.indigo)
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 5, height: 5)))
        }
        .rotationEffect(.degrees(degrees), anchor: .top)
    }
    
    private func setRotationState() {
        let baseAnimation = Animation.easeInOut(duration: 1)
        let repeated = baseAnimation.repeatForever(autoreverses: true)
        withAnimation(repeated) {
            switch self.rotationState {
            case .max:
                self.rotationState = .min
            case .min:
                self.rotationState = .max
            }
        }
    }
    
}

#Preview {
    Pendulum()
}
