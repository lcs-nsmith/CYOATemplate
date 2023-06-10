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
    
    @State var previousNodes: [Int] = [1]
    
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
                    ZStack {
                        Text("Back")
                            .retroFont(.pixelEmulator, size: 14)
                            .foregroundColor(.white)
                            .opacity(retroGameFontActive ? 1 : 0)
                        Text("Back")
                            .font(.system(size: 16, weight: .medium, design: .monospaced))
                            .foregroundColor(.white)
                            .opacity(retroGameFontActive ? 0 : 1)
                    }
                    .opacity(previousNodes.count > 1 ? 1 : 0)
                    .onTapGesture {
                        previousNodes.popLast()
                        currentNodeId = previousNodes.last!
                    }
                    Spacer()
                }
                .padding()
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
            .opacity(currentNodeId < 55 || currentNodeId > 60 ? 1 : 0)
            VStack {
                HStack {
                    Button("Back", action: {
                        previousNodes.popLast()
                        currentNodeId = previousNodes.last!
                    })
                    Spacer()
                }
                Spacer()
                SpinnerView(currentNodeId: $currentNodeId)
                Spacer()
            }
            .opacity(currentNodeId < 55 || currentNodeId > 60 ? 0 : 1)
        }
        .onChange(of: currentNodeId) { newNodeId in
            if newNodeId != previousNodes.last {
                previousNodes.append(newNodeId)
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

