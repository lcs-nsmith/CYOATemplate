//
//  GameView.swift
//  CYOATemplate
//
//  Created by Russell Gordon on 2023-05-29.
//

import Blackbird
import SwiftUI

struct GameView: View {
    
    // MARK: Stored properties
    @State var currentNodeId: Int = 1
    
    // MARK: Computed properties
    var body: some View {
        ZStack {
            VStack(spacing: 10) {
                
                HStack {
                    Text("\(currentNodeId)")
                        .font(.largeTitle)
                    Spacer()
                }
                
                NodeView(currentNodeId: currentNodeId)
                
                Divider()
                
                EdgesView(currentNodeId: $currentNodeId)
                
                Spacer()
                
            }
            .padding()
            .opacity(currentNodeId < 55 || currentNodeId > 60 ? 1 : 0)
            SpinnerView(currentNodeId: $currentNodeId)
                .opacity(currentNodeId < 55 || currentNodeId > 60 ? 0 : 1)
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
        // Make the database available to all other view through the environment
            .environment(\.blackbirdDatabase, AppDatabase.instance)
    }
}
