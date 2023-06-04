//
//  SpinnerView.swift
//  CYOATemplate
//
//  Created by Jacobo de Juan Millon on 2023-06-04.
//

import SwiftUI

struct SpinnerView: View {
    var size: Double
    var percentage1: Double
    var percentage2: Double
    var totalRotation: Double {
        return Double(Int.random(in: 3...5)) + Double(Int.random(in: 0...99)) / 100 + 0.005
    }
    @State var currentRotation = 0.0
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: percentage1 / 100)
                .stroke(Color(hue: 0,
                              saturation: 1.0,
                              brightness: 1.0),
                        lineWidth: size)
                .frame(width: size, height: size)
                
            Circle()
                .trim(from: percentage1 / 100, to: (percentage1 + percentage2) / 100)
                .stroke(Color(hue: 1/6,
                            saturation: 1.0,
                            brightness: 1.0),
                        lineWidth: size)
                .frame(width: size, height: size)
            Circle()
                .trim(from: (percentage1 + percentage2) / 100, to: 1)
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
                    percentage1: 55,
                    percentage2: 25)
    }
}
