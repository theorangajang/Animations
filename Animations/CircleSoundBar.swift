//
//  CircleSoundBar.swift
//  Animations
//
//  Created by Alex Jang on 1/10/24.
//

import SwiftUI

private enum SliderOption: CaseIterable {
    
    case height
    case radius
    case barTotal
    
}

private struct SliderInfo {
    
    let label: String
    let info: Binding<CGFloat>
    let min: CGFloat
    let max: CGFloat
    
}

struct CircleSoundBar: View {

    private static let animation: Animation = .easeInOut(duration: 0.75)
    
    private static let minHeight: CGFloat = 20
    private static let maxHeight: CGFloat = 100
    
    private static let minBars: CGFloat = 5
    private static let maxBars: CGFloat = 360
    
    private static let minRadius: CGFloat = 20
    private static let maxRadius: CGFloat = 100
    
    @State private var barHeight: CGFloat = 100
    @State private var totalBars: CGFloat = 25
    @State private var radius: CGFloat = 80
    @State private var shouldAlternate: Bool = false
    
    private let sliders = SliderOption.allCases
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea(edges: .all)
            VStack {
                Spacer()
                self.edges
                Spacer()
                VStack(spacing: 20) {
                    ForEach(self.sliders, id: \.self) { slider in
                        sliderContent(for: slider)
                    }
                }
                .padding(.horizontal, Padding.large)
                .padding(.bottom, 20)
            }
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
                self.shouldAlternate.toggle()
            }
        }
    }
    
    private var edges: some View {
        ZStack {
            ForEach(0...Int(self.totalBars), id: \.self) { i in
                ZStack {
                    Rectangle()
                        .frame(width: 1, height: CGFloat.random(in: Self.minHeight...self.barHeight))
                        .foregroundStyle(.blue)
                }
                .frame(height: Self.maxHeight, alignment: .bottom)
                .offset(y: (self.radius * 2) < Self.maxHeight ? (Self.maxHeight - (self.radius * 2)) : -self.radius)
                .rotationEffect(.degrees((360/self.totalBars) * Double(i)))
                .animation(Self.animation, value: self.barHeight)
                .animation(Self.animation, value: self.radius)
            }
            .animation(Self.animation, value: self.totalBars)
            .animation(Self.animation, value: self.shouldAlternate)
        }
    }
    
    @ViewBuilder
    private func sliderContent(for option: SliderOption) -> some View {
        let sliderInfo = sliderInfo(for: option)
        VStack(alignment: .leading) {
            Text(sliderInfo.label)
                .foregroundStyle(.white)
            Slider(
                value: sliderInfo.info,
                in: sliderInfo.min...sliderInfo.max,
                label: {},
                minimumValueLabel: {
                    sliderLabel(amt: sliderInfo.min)
                },
                maximumValueLabel: {
                    sliderLabel(amt: sliderInfo.max)
                }
            )
        }
    }

    private func sliderLabel(amt: Double) -> some View {
        Text("\(Int(amt))")
            .foregroundStyle(.white)
    }
    
    private func sliderInfo(for option: SliderOption) -> SliderInfo {
        switch option {
        case .height:
            SliderInfo(
                label: "Height: \(Int(self.barHeight))",
                info: self.$barHeight,
                min: Self.minHeight,
                max: Self.maxHeight
            )
        case .radius:
            SliderInfo(
                label: "Radius: \(Int(self.radius))",
                info: self.$radius,
                min: Self.minRadius,
                max: Self.maxRadius
            )
        case .barTotal:
            SliderInfo(
                label: "Total: \(Int(self.totalBars))",
                info: self.$totalBars,
                min: Self.minBars,
                max: Self.maxBars
            )
        }
    }
    
}

#Preview {
    CircleSoundBar()
}
