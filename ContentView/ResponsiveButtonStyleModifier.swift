//
//  ResponsiveButtonStyleModifier.swift
//  ContentView
//
//  Created by Luiza Poghosyan on 06.07.23.
//

import Foundation
import SwiftUI

struct ResponsiveButtonStyleModifier: ViewModifier {
    var isValid: Bool

    func body(content: Content) -> some View {
        func getButtonColor() -> Color {
//            if content
//                return Color(red: 29/255, green: 104/255, blue: 150/255).opacity(0.8)
//            }
            if isValid {
                return Color(red: 64/255, green: 160/255, blue: 218/255)
            }
            else {
                return Color(red: 64/255, green: 160/255, blue: 218/255).opacity(0.25)
            }
        }
        
        return content
            .frame(maxWidth: UIScreen.main.bounds.width * 0.75)
            .font(.system(size: 18))
            .padding()
            
            .foregroundColor(.white)
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color.white, lineWidth: 2)
            )
            .disabled(!isValid)
            .background(getButtonColor())
            .cornerRadius(25)
//            .gesture(
//                LongPressGesture(minimumDuration: 0)
//                    .onChanged { _ in self.isButtonPressed = true }
//                    .onEnded { _ in self.isButtonPressed = false }
//            )
    }
    //Color(red: 29/255, green: 104/255, blue: 150/255).opacity(0.8)
    
}
