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

struct DraggableButton: View {
	@GestureState private var dragAmount = CGSize.zero

	let action: () -> Void
	let label: () -> Text

	var body: some View {
		let isPressed = dragAmount.width != 0 || dragAmount.height != 0
		
		return Button(action: action) {
			label()
				.padding()
				.background(Color.blue)
				.foregroundColor(.white)
				.cornerRadius(10)
		}
		.scaleEffect(isPressed ? 0.9 : 1)
		.rotation3DEffect(
			.degrees(Double(dragAmount.width / 10 - dragAmount.height / 10)),
			axis: (x: 10.0, y: -10.0, z: 0.0)
		)
		.animation(.spring(), value: isPressed)
		.gesture(
			LongPressGesture(minimumDuration: 0)
				.sequenced(before: DragGesture())
				.updating($dragAmount) { value, state, transaction in
					switch value {
					case .first(true):
						state = .zero
					case .second(_, let drag):
						state = drag?.translation ?? .zero
					default:
						break
					}
				}
		)
	}
}


struct ContentView: View {
	
	
	@State var input = ""
	@State var extraButtonsVisible = false


	
	
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
//					Spacer()
					//Display and delete
					ZStack{
						RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
							.background(.ultraThinMaterial)
							.opacity(0.1)
						HStack{
//							Spacer()
							
							Text(input)
								.font(.system(.largeTitle))
								.fontWeight(.bold)
								.frame(maxWidth: .infinity)
								.padding()
							
							//Fix later
							
//							Spacer()
							VStack{
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
								.padding()

								//Expand button
							Button(
								action: {
									let impactLig = UIImpactFeedbackGenerator(style: .light)
									impactLig.impactOccurred()
									extraButtonsVisible.toggle()
								}){
									Image(systemName: "gyroscope")
										.frame(maxWidth: 50, maxHeight: 50)
										.contentShape(Rectangle())
									
								}
								.buttonStyle(.bordered)
								.padding()
							}
							
//							Spacer()
							
						}
					}
					.padding()
					.frame(idealHeight:50, maxHeight: 300)

					
					
					Spacer()

					//Extra buttons
					if(extraButtonsVisible){
					HStack{
						Button(action: {
							//Take the log of the input
							let impactMed = UIImpactFeedbackGenerator(style: .medium)
							impactMed.impactOccurred()
							if(input.isEmpty == false && input.last?.isNumber==true){
								input = evaluateExpression(input)
								input = String(log10(Double(input)!))
							}
							
						})
						{
							Text("LOG")
								.fontWeight(.bold)
								.frame(maxWidth: .infinity, maxHeight: 50)
								.contentShape(Rectangle())
							
						}.buttonStyle(.bordered)
							.transition(.scale)
							
						
						Button(action: {
							//Replace input with PI
							let impactMed = UIImpactFeedbackGenerator(style: .medium)
							impactMed.impactOccurred()
							input = "3.141592653589793238462643383279502884197169399375105820974944592307816406286"
						})
						{
							Text("π")
								.fontWeight(.bold)
								.frame(maxWidth: .infinity, maxHeight: 50)
								.contentShape(Rectangle())
							
						}.buttonStyle(.bordered)
							.transition(.opacity)
					}
					
					}
					
					Spacer()

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
											if(input == "Error" || input == "nan"){
												input = "\(i + (j*3))"
											} else {
												input += "\(i + (j*3))"
											}
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
									if(input == "Error" || input == "nan"){
										input = "0"
									} else {
										input += "0"
									}
									let impactMed = UIImpactFeedbackGenerator(style: .medium)
									impactMed.impactOccurred()
								}){
									Text("0")
										.font(.title)
										.fontWeight(.bold)
										.frame(maxWidth: geometry.size.width * 3/4, maxHeight: .infinity)
								}
								
								.buttonStyle(.bordered)
								Button( action:{
									if(input.isEmpty || input == "Error" || input == "nan"){
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
										.frame(maxWidth: geometry.size.width * 1/4, maxHeight: .infinity)
								}
								.buttonStyle(.bordered)
								Spacer()
							}
						}
						.frame(maxWidth: geometry.size.width * 3/4)
						
						//Operation buttons
						VStack(){
							Button(action:{
								if(input.isEmpty==false && input.last?.isNumber==true){
									input += "+"
								} else if(input == "Error" || input == "nan"){
									input = ""
								}else{
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
								} else if(input == "Error" || input == "nan"){
									input = ""
								}else{
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
								}  else if(input == "Error" || input == "nan"){
									input = ""
								}else{
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
								}  else if(input == "Error" || input == "nan"){
									input = ""
								}else{
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


				   
