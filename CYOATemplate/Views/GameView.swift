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
    
    @Binding var retroGameFontActive: Bool
    
    @State private var showingPopover = false
    
    // MARK: Computed properties
    var body: some View {
        
        ZStack {
            if retroGameFontActive == true {
                Color(.systemCyan)
                    .ignoresSafeArea()
            } else {
                Color(.systemYellow)
                    .ignoresSafeArea()
            }
            
            VStack {
                
                HStack {
                    
                    if retroGameFontActive == true {
                        Text("\(currentNodeId)")
                            .retroFont()
                            .padding(.leading)
                    } else {
                        Text("\(currentNodeId)")
                            .font(.system(size: 35, weight: .medium, design: .monospaced))
                            .padding(.leading)
                    }
                    
                    Spacer()
                    
                    Label(title: {
                        Text("")
                        //                        Text("Settings")
                        
                    }, icon: {
                        Image(systemName: "gearshape.2")
                        
                    })
                    .padding(.trailing)
                    .onTapGesture {
                        showingPopover = true
                    }
                    .popover(isPresented: $showingPopover) {
                        HStack {
                            
                            VStack {
                                HStack {
                                    Text("Retro Mode")
                                        .padding()
                                    Toggle("", isOn: $retroGameFontActive)
                                        .padding()
                                }
                                Spacer()
                            }
                            
                            Spacer()
                            
                            VStack {
                                Button(action: {
                                    showingPopover = false
                                }, label: {
                                    Label(title: {
                                        Text("Back")
                                    }, icon: {
                                        Image(systemName: "arrowshape.turn.up.backward")
                                    })
                                    .foregroundColor(.blue)
                                    .padding()
                                })
                                
                                Spacer()
                                
                            }
                            
                        }
                    }
                    .padding()
                }
                
                if retroGameFontActive == true {
                        NodeView(currentNodeId: currentNodeId, retroGameFontActive: retroGameFontActive)
                            .retroFont(.pixelEmulator, size: 14)
                            .padding(.horizontal)
                } else {
                    NodeView(currentNodeId: currentNodeId, retroGameFontActive: retroGameFontActive)
                        .padding(.horizontal)
                }
                
                Divider()
                
                EdgesView(currentNodeId: $currentNodeId, retroGameFontActive: retroGameFontActive)
                    .padding(.trailing)
                
                Spacer()
                
            }
        }
    }
}


struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(retroGameFontActive: .constant(false))
        // Make the database available to all other view through the environment
            .environment(\.blackbirdDatabase, AppDatabase.instance)
    }
}

