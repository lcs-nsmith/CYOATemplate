//
//  SpinnerView.swift
//  CYOATemplate
//
//  Created by Jacobo de Juan Millon on 2023-06-04.
//

import SwiftUI

struct SpinnerView: View {
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: 30/100)
                .stroke(Color(hue: 0,
                              saturation: 1.0,
                              brightness: 1.0),
                        lineWidth: 200)
                .frame(width: 200, height: 200)
                
            Circle()
                .trim(from: 30/100, to: 60/100)
                .stroke(Color(hue: 1/6,
                            saturation: 1.0,
                            brightness: 1.0),
                        lineWidth: 200)
                .frame(width: 200, height: 200)
            Circle()
                .trim(from: 60/100, to: 100/100)
                .stroke(Color(hue: 1/3,
                            saturation: 1.0,
                            brightness: 1.0),
                      lineWidth: 200)
                .frame(width: 200, height: 200)
                
        }
    }
}

struct SpinnerView_Previews: PreviewProvider {
    static var previews: some View {
        SpinnerView()
    }
}
