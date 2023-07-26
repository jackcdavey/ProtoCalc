//
//  ContentView.swift
//  ProtoCalc
//
//  Created by Jack Davey on 7/24/23.
//

import SwiftUI
import Expression




struct ContentView: View {
    @State var input = ""
    
    func evaluateExpression(_ expression: String) -> String {
        let expression = Expression(expression)
        if let result = try? expression.evaluate() {
            let resultStr: String = (result.truncatingRemainder(dividingBy: 1) == 0) ? String(format: "%.0f", result) : String(result)
            return resultStr
        } else {
            return "Error"
        }
    }




    
    
    
    var body: some View {
        HStack{
            Spacer()
            Text(input).bold()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .contentShape(Rectangle())
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
        
        HStack{
            
            VStack{
//                Other function btns
                HStack{
                    Spacer()
                    Button(action: {
                        input = ""
                        let impactMed = UIImpactFeedbackGenerator(style: .medium)
                        impactMed.impactOccurred()
                    })
                    {
                        Text("C")
                            .font(.title)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .contentShape(Rectangle())
                    }
                    .buttonStyle(.bordered)
                    
                    Button(action: {
                        if(input.isEmpty == false){
                            if(input.prefix(1) != "-"){
                                input = "-" + input
                            } else{
                                input.removeFirst()
                            }
                        }
                        let impactMed = UIImpactFeedbackGenerator(style: .medium)
                        impactMed.impactOccurred()
                    })
                    {
                        Text("\u{207A}\u{2215}\u{208B}")
                            .font(.title)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .contentShape(Rectangle())
                    }
                    .buttonStyle(.bordered)
                    
                    Button(action: {
                        let impactMed = UIImpactFeedbackGenerator(style: .medium)
                        impactMed.impactOccurred()
                        if(input.isEmpty == false){
                            input += "/100"
                            input = evaluateExpression(input)
                        }
                    })
                    {
                        Text("%")
                            .font(.title)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .contentShape(Rectangle())
                    }
                    .buttonStyle(.bordered)
                    
                    Spacer()

                }
                
                
                
                //            Number buttons
                ForEach(0..<3){ j in
                    HStack{
                        Spacer()
                        ForEach(1 ..< 4) { i in
                            Button(action: {
                                input += "\(i + (j*3))"
                                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                                impactMed.impactOccurred()
                            }) {
                                Text("\(i + (j*3))")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .contentShape(Rectangle())
                            }
                            .buttonStyle(.bordered)
                            
                        }
                        Spacer()
                    }
                }
                
                GeometryReader { geometry in
                    HStack{
                        Spacer()
                        Button( action:{
                            input += "0"
                            let impactMed = UIImpactFeedbackGenerator(style: .medium)
                            impactMed.impactOccurred()
                        }){
                            Text("0")
                                .font(.title)
                                .fontWeight(.bold)
                                .frame(maxWidth: geometry.size.width * 3/4, maxHeight: .infinity)
                                .contentShape(Rectangle())
                        
                        }
                        
                        .buttonStyle(.bordered)

                        Button( action:{
                            input += "."
                            let impactMed = UIImpactFeedbackGenerator(style: .medium)
                            impactMed.impactOccurred()
                        }){
                            Text(".")
                                .font(.title)
                                .fontWeight(.bold)
                                .frame(maxWidth: geometry.size.width * 1/4, maxHeight: .infinity)
                                .contentShape(Rectangle())
                        
                        }
                        
                        .buttonStyle(.bordered)

                        Spacer()
                    }
                }

                

            }
            
            //            Operation buttons
            

            VStack{
                Button(action:{
                    if(input.isEmpty==false){
                        input += "+"
                    }
                    let impactMed = UIImpactFeedbackGenerator(style: .medium)
                    impactMed.impactOccurred()
                }){
                    Text("+")
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .contentShape(Rectangle())
                }.buttonStyle(.bordered)
                
                Button(action:{
                    if(input.isEmpty==false){
                        input += "-"
                    }
                    let impactMed = UIImpactFeedbackGenerator(style: .medium)
                    impactMed.impactOccurred()
                }){
                    Text("-")
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .contentShape(Rectangle())
                }.buttonStyle(.bordered)
                
                
                Button(action:{
                    if(input.isEmpty==false){
                        input += "*"
                    }
                    let impactMed = UIImpactFeedbackGenerator(style: .medium)
                    impactMed.impactOccurred()
                }){
                    Text("x")
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .contentShape(Rectangle())
                }.buttonStyle(.bordered)
                
                Button(action:{
                    if(input.isEmpty==false){
                        input += "/"
                    }
                    let impactMed = UIImpactFeedbackGenerator(style: .medium)
                    impactMed.impactOccurred()
                }){
                    Text("÷")
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .contentShape(Rectangle())
                }.buttonStyle(.bordered)
                
                Button(action:{
                    let impactMed = UIImpactFeedbackGenerator(style: .medium)
                    impactMed.impactOccurred()
                    if(input.isEmpty == false){
                        input = evaluateExpression(input)
                    }
                }){
                    Text("=")
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .contentShape(Rectangle())
                }.buttonStyle(.bordered)

                
            }
            .frame(maxWidth: 50)
            Spacer()

            
        }
    }
        
    
}

                   
