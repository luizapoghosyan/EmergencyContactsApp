//
//  Contact.swift
//  ContentView
//
//  Created by Luiza Poghosyan on 04.07.23.
//

import Foundation

struct Contact: Identifiable {
    let id = UUID()
    var firstName: String
    var lastName: String
    var phoneNumber: String

    var fullName: String {
        return "\(firstName) \(lastName)"
    }

    init(firstName: String = "", lastName: String = "", phoneNumber: String = "") {
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
    }
}

