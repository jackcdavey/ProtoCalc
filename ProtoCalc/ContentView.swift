//
//  ContentView.swift
//  ProtoCalc
//
//  Created by Jack Davey on 7/24/23.
//

import SwiftUI

struct ContentView: View {
    @State var input = ""
    var body: some View {
        
        HStack{
            Spacer()
            Text(input).bold()
            Spacer()
//            Delete button
            Button(
                action: {
                    if(input.count > 0){
                        input.removeLast()
                    }
                }){
                    Image(systemName: "delete.left")
                }
            .buttonStyle(.bordered)
            
            Spacer()
            
        }
        VStack {
            VStack{
                
                ForEach(0..<3){ j in
                    HStack{
                        ForEach(1 ..< 4) { i in
                            Button("\(i + (j*3))", action: {
                                input += "\(i + (j*3))"
                                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                                    impactMed.impactOccurred()
                            }).buttonStyle(.bordered)
                        }
                    }
                }
                HStack{
                    Button("0", action:{
                        input += "0"
                    }).buttonStyle(.bordered)
                }
                
                Button("CLEAR", role: .destructive, action:{
                    input = ""
                })
                }
            }
        }
    
}

    #Preview {
        ContentView()
    }
                   
