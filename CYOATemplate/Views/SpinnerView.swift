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
    var color1: Int
    var color2: Int
    var color3: Int
    @State var opacity = 0.0
    @Binding var outcome: Int
    @State var totalRotation = 0.0
    @State var currentRotation = 0.0
    var body: some View {
        VStack(spacing: size) {
            ZStack {
                Circle()
                    .trim(from: 0, to: Double(visualPercentage1) / 100)
                    .stroke(Color(color[color1]),
                            lineWidth: size)
                    .frame(width: size, height: size)
                
                Circle()
                    .trim(from: Double(visualPercentage1) / 100, to: Double(visualPercentage1 + visualPercentage2) / 100)
                    .stroke(Color(color[color2]),
                            lineWidth: size)
                    .frame(width: size, height: size)
                Circle()
                    .trim(from: Double(visualPercentage1 + visualPercentage2) / 100, to: 1)
                    .stroke(Color(color[color3]),
                            lineWidth: size)
                    .frame(width: size, height: size)
                ArrowView(size: size * 0.75, width: 5)
                    .offset(x: 0, y: -size * 0.375)
                    .rotationEffect(Angle(degrees: 360 * currentRotation))
            }
            Button("Continue", action: {
                
            })
            .opacity(opacity)
        }
        .task {
            withAnimation(.linear(duration: totalRotation * 0.85)) {
                currentRotation = totalRotation
            }
            withAnimation(.linear(duration: 0.1).delay(totalRotation * 0.85)) {
                opacity = 1.0
            }
        }
        .onAppear {
            let result = Int.random(in: 0...99)
            if result < actualPercentage1 {
                outcome = 1
                totalRotation = Double(Int.random(in: 3...5)) + Double(Int.random(in: 0..<visualPercentage1)) / 100 + 0.255
            }
            else if result < actualPercentage1 + actualPercentage2 {
                outcome = 2
                totalRotation = Double(Int.random(in: 3...5)) + Double(Int.random(in: visualPercentage1..<visualPercentage1 + visualPercentage2)) / 100 + 0.255
            }
            else {
                outcome = 3
                totalRotation = Double(Int.random(in: 3...5)) + Double(Int.random(in: visualPercentage1 + visualPercentage2...99)) / 100 + 0.255
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
                    color1: 0,
                    color2: 1,
                    color3: 2,
                    outcome: .constant(1))
    }
}
