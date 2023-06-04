//
//  SpinnerView.swift
//  CYOATemplate
//
//  Created by Jacobo de Juan Millon on 2023-06-04.
//

import SwiftUI

struct SpinnerView: View {
    var size: Double
    var visualPercentage1: Int
    var visualPercentage2: Int
    var actualPercentage1: Int
    var actualPercentage2: Int
    @Binding var outcome: Int
    var totalRotation: Double {
        let result = Int.random(in: 0...99)
        if result < actualPercentage1 {
            outcome = 1
            return Double(Int.random(in: 3...5)) + Double(Int.random(in: 0..<visualPercentage1)) / 100 + 0.005
        }
        if result < actualPercentage1 + actualPercentage2 {
            outcome = 2
            return Double(Int.random(in: 3...5)) + Double(Int.random(in: visualPercentage1..<visualPercentage1 + visualPercentage2)) / 100 + 0.005
        }
        outcome = 3
        return Double(Int.random(in: 3...5)) + Double(Int.random(in: visualPercentage1 + visualPercentage2...99)) / 100 + 0.005
    }
    @State var currentRotation = 0.0
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: Double(visualPercentage1) / 100)
                .stroke(Color(hue: 0,
                              saturation: 1.0,
                              brightness: 1.0),
                        lineWidth: size)
                .frame(width: size, height: size)
                
            Circle()
                .trim(from: Double(visualPercentage1) / 100, to: Double(visualPercentage1 + visualPercentage2) / 100)
                .stroke(Color(hue: 1/6,
                            saturation: 1.0,
                            brightness: 1.0),
                        lineWidth: size)
                .frame(width: size, height: size)
            Circle()
                .trim(from: Double(visualPercentage1 + visualPercentage2) / 100, to: 1)
                .stroke(Color(hue: 1/3,
                            saturation: 1.0,
                            brightness: 1.0),
                      lineWidth: size)
                .frame(width: size, height: size)
            ArrowView(size: size * 0.75, width: 5)
                .offset(x: 0, y: -size * 0.375)
                .rotationEffect(Angle(degrees: 360 * currentRotation))
        }
        .task {
            withAnimation(.linear(duration: totalRotation * 0.85)) {
                currentRotation = totalRotation
            }
        }
    }
}

struct SpinnerView_Previews: PreviewProvider {
    static var previews: some View {
        SpinnerView(size: 100,
                    visualPercentage1: 55,
                    visualPercentage2: 25,
                    actualPercentage1: 90,
                    actualPercentage2: 5,
                    outcome: .constant(1))
    }
}
