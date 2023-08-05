////
////  SuggestionList.swift
////  ProtoCalc
////
////  Created by Jack Davey on 7/29/23.
////
//
//import SwiftUI
//
//struct SuggestionList: View {
//	var body: some View {
//		GeometryReader{ geometry in
//			ScrollView{
//				VStack{
//					
//					ForEach(0..<5){idx in
//						CardView(text: "Hello" + String(idx), height: geometry.size.height/5)
//							.padding()
//							
//					
//						
//					}
//				}
//			}
//			
//		}
//		.padding()
//	}
//}
//
//struct CardView: View {
//	var text: String = ""
//	var height: CGFloat = 50
//	
//	var body: some View {
//		ZStack {
//			RoundedRectangle(cornerRadius: 10)
//				.fill(Color.white)
//				.shadow(radius: 3)
//			Text(text)
//				.padding()
//		}
//		.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: height)
//	}
//}
//
//
//#Preview {
//	SuggestionList()
//}
