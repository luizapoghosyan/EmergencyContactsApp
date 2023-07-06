//
//  UIKitTextField.swift
//  ContentView
//
//  Created by Luiza Poghosyan on 06.07.23.
//

import Foundation
import SwiftUI

struct UIKitTextField: UIViewRepresentable {
    let mask: String
    let placeholder: String
        
    @Binding var text: String
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        textField.placeholder = placeholder
        return textField
    }
    
    func updateUIView(_ textField: UITextField, context: Context) {
        textField.text = text
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: UIKitTextField
        
        init(parent: UIKitTextField) {
            self.parent = parent
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            guard let oldText = textField.text as NSString? else {
                return true
            }
            let newText = oldText.replacingCharacters(in: range, with: string)
            parent.text = format(input: newText, mask: parent.mask)
            return false
        }
        
        func format(input: String, mask: String) -> String {
            let digits = input.filter({ $0.isWholeNumber })
            var result = ""
            var index = digits.startIndex
            
            for char in mask where index < digits.endIndex {
                if char == "X" {
                    result.append(digits[index])
                    index = digits.index(after: index)
                } else {
                    result.append(char)
                }
            }
            
            return result
        }
    }
}
