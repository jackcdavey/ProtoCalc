//
//  TestingRange.swift
//  ProtoCalc
//
//  Created by Jack Davey on 7/26/23.
//

import Foundation
import SwiftUI

let backgroundGradient = LinearGradient(
    colors: [Color.red, Color.blue],
    startPoint: .top, endPoint: .bottom)


struct TestingRange: View {
    @State private var name: String = ""
    @GestureState private var dragState = DragState.inactive
    @State var flagPosition: CGSize = .zero
    @State private var isDragging: Bool = false
    
    var body: some View {
        ZStack {
            backgroundGradient
                .ignoresSafeArea()
            VStack {
                
                Label("Flag", systemImage: "flag.fill")
                                    .padding()
                                    .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 8))
                                    .offset(flagPosition)
                                    .scaleEffect(isDragging ? 1.1 : 1.0)
                                    .rotation3DEffect(.degrees(isDragging ? 1 : 0), axis: (x: 0, y: 1, z: 0))
                                    .animation(.easeInOut, value: isDragging)
                                    .gesture(
                                        DragGesture()
                                            .onChanged { value in
                                                self.flagPosition = value.translation
                                                self.isDragging = true
                                            }
                                            .onEnded { value in
                                                self.flagPosition = value.translation
                                                self.isDragging = false
                                            }
                                    )
                
                Text("Welcome")
                    .font(.title)
                HStack {
                    TextField("Your name?", text: $name)
                        .textFieldStyle(.roundedBorder)
                    Button(action: {}, label: {
                        Image(systemName: "arrow.right.square")
                            .font(.title)
                    })
                }
                .padding()
            }
        }
        
    }
}

enum DragState {
    case inactive
    case pressing
    case dragging(translation: CGSize)
    
    var translation: CGSize {
        switch self {
        case .inactive, .pressing:
            return .zero
        case .dragging(let translation):
            return translation
        }
    }
    
    var isPressing: Bool {
        switch self {
        case .pressing, .dragging:
            return true
        case .inactive:
            return false
        }
    }
}
struct TestingRange_Previews: PreviewProvider {
    static var previews: some View {
        TestingRange()
    }
}

