//
//  ResponsiveButtonStyleModifier.swift
//  ContentView
//
//  Created by Luiza Poghosyan on 06.07.23.
//

import Foundation
import SwiftUI

struct ResponsiveButtonStyle: ButtonStyle {
    var disabled: Bool
    func makeBody(configuration: Self.Configuration) -> some View {
        func getButtonColor() -> Color {
            if configuration.isPressed {
                return Color(red: 29/255, green: 104/255, blue: 150/255).opacity(0.8)
            }
            if disabled {
                return Color(red: 64/255, green: 160/255, blue: 218/255).opacity(0.25)
            } else {
                return Color(red: 64/255, green: 160/255, blue: 218/255)
            }
        }
        return configuration.label
                .frame(maxWidth: UIScreen.main.bounds.width * 0.75)
                .font(.system(size: 18))
                .padding()
                
                .foregroundColor(.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.white, lineWidth: 2)
                )
                .disabled(disabled)
                .background(getButtonColor())
                .cornerRadius(25)
    }

}

