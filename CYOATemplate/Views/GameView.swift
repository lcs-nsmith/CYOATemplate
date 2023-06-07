//
//  GameView.swift
//  CYOATemplate
//
//  Created by Russell Gordon on 2023-05-29.
//

import Blackbird
import RetroText
import SwiftUI

struct GameView: View {
    
    // MARK: Stored properties
    @State var currentNodeId: Int = 1
    
    @Binding var retroGameFontGameView: Bool
    
    // MARK: Computed properties
    var body: some View {
        
        ZStack {
            Color(.systemGreen)
                .ignoresSafeArea()
            
            VStack(spacing: 10) {
                
                HStack {
                    
                    if retroGameFontGameView == true {
                        Text("\(currentNodeId)")
                            .retroFont(.pixelEmulator)
                    } else {
                        Text("\(currentNodeId)")
                            .font(.system(size: 35, weight: .medium, design: .monospaced))
                    }
                    
                    Spacer()
                }
                
                NodeView(currentNodeId: currentNodeId)
                
                Divider()
                
                EdgesView(currentNodeId: $currentNodeId)
                
                Spacer()
                
            }
            .padding()
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(retroGameFontGameView: .constant(false))
        // Make the database available to all other view through the environment
            .environment(\.blackbirdDatabase, AppDatabase.instance)
    }
}
