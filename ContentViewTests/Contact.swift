//
//  Contact.swift
//  ContentViewTests
//
//  Created by Luiza Poghosyan on 07.07.23.
//

import XCTest
@testable import ContentView

class ContactTests: XCTestCase {
    
    func testContactInitialization() {
        let contact = Contact(firstName: "John", lastName: "Doe", phoneNumber: "(123) 456-7890")
        
        XCTAssertEqual(contact.firstName, "John")
        XCTAssertEqual(contact.lastName, "Doe")
        XCTAssertEqual(contact.phoneNumber, "(123) 456-7890")
    }
    
    func testFullName() {
        let contact = Contact(firstName: "John", lastName: "Doe", phoneNumber: "(123) 456-7890")
        
        XCTAssertEqual(contact.fullName, "John Doe")
    }
}
