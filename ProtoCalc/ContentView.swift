//
//  ContentView.swift
//  ProtoCalc
//
//  Created by Jack Davey on 7/24/23.
//

import SwiftUI
import Expression

extension String {
    var isNumber: Bool {
        return self.range(
            of: "^[0-9]*$", // 1
            options: .regularExpression) != nil
    }
}

struct ContentView: View {
    
    
    @State var input = ""

    
    
    func evaluateExpression(_ expression: String) -> String {
        let expression = Expression(expression)
        if(input.last == "+" || input.last == "-" || input.last == "*" || input.last == "/"){
            input.removeLast()
            return input
        }else if let result = try? expression.evaluate() {
            let resultStr: String = (result.truncatingRemainder(dividingBy: 1) == 0) ? String(format: "%.0f", result) : String(result)
            return resultStr
        } else {
            return "Error"
        }
    }
    
    var body: some View {
		VStack{
			GeometryReader { geometry in
				VStack{
					//Display and delete
					HStack{
						Spacer()
						
						Text(input)
							.font(.system(.largeTitle))
							.fontWeight(.bold)
							.frame(maxWidth: .infinity, maxHeight: .infinity)
							.contentShape(Rectangle())
						
						//Fix later
						
						Spacer()
						//Delete button
						Button(
							action: {
								let impactLig = UIImpactFeedbackGenerator(style: .light)
								impactLig.impactOccurred()
								if(input.count > 0){
									input.removeLast()
								}
							}){
								Image(systemName: "delete.left")
									.frame(maxWidth: 50, maxHeight: 50)
									.contentShape(Rectangle())
								
							}
							.buttonStyle(.bordered)
						
						Spacer()
						
					}
					
					
					HStack(spacing: -1.0){
						VStack{
							//Other function btns
							HStack{
								Spacer()
								Button(action: {
									input = ""
									let impactHev = UIImpactFeedbackGenerator(style: .heavy)
									impactHev.impactOccurred()
								})
								{
									Text("C")
										.font(.title)
										.fontWeight(.bold)
										.frame(maxWidth: .infinity, maxHeight: .infinity)
										.contentShape(Rectangle())
									
								}
								.buttonStyle(.bordered)
								.foregroundColor(Color.white) // Changes the text color to white
								.background(Color.red) // Changes the button's background color to red
								.clipShape(RoundedRectangle(cornerRadius: 10)) // Rounds the corners
								
								
								
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
							
							
							
							//Number buttons
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
							
							
							//0 and decimal buttons
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
										.frame(maxWidth: .infinity, maxHeight: .infinity)
								}
								
								.buttonStyle(.bordered)
								Button( action:{
									if(input.isEmpty){
										input = "0."
									} else if(input.contains(".") == false){
										input += "."
									} else {
										//Remove the decimal and place it at the end of input
										let index = input.firstIndex(of: ".")
										input.remove(at: index!)
										input += "."
									}
									let impactMed = UIImpactFeedbackGenerator(style: .medium)
									impactMed.impactOccurred()
								}){
									Text(".")
										.font(.title)
										.fontWeight(.bold)
										.frame(maxWidth: .infinity, maxHeight: .infinity)
									
									
									
									
									
								}
								
								.buttonStyle(.bordered)
								
								
								
								Spacer()
							}
							
							
						}
						.frame(maxWidth: geometry.size.width * 3/4)
						
						//Operation buttons
						HStack{
							VStack(){
								Button(action:{
									if(input.isEmpty==false && input.last?.isNumber==true){
										input += "+"
									} else{
										input.removeLast()
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
									if(input.isEmpty==false && input.last?.isNumber==true){
										input += "-"
									} else{
										input.removeLast()
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
									if(input.isEmpty==false && input.last?.isNumber==true){
										input += "*"
									}  else{
										input.removeLast()
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
									if(input.isEmpty==false && input.last?.isNumber==true){
										input += "/"
									}  else{
										input.removeLast()
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
							.frame(maxWidth: geometry.size.width * 1/4)
							Spacer()
								.frame(width: 10.0)
						}
					}
					.frame(maxWidth: .infinity, maxHeight: geometry.size.height * 1/2)
					
					
				}
				
				
			}
			
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


                   
