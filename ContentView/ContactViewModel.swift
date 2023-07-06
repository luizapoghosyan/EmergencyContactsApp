//
//  ContactViewModel.swift
//  ContentView
//
//  Created by Luiza Poghosyan on 04.07.23.
//

import Foundation

class ContactViewModel: ObservableObject {
    @Published var contacts = [Contact]()
//    @Published var validationResult = false
       
    func addContact(firstName: String, lastName: String, phoneNumber: String) {
        let newContact = Contact(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber)
        contacts.append(newContact)
    }
       
    func deleteContact(_ contact: Contact) {
        if let index = contacts.firstIndex(where: { $0.id == contact.id }) {
            contacts.remove(at: index)
        }
    }
       
    func editContact(_ contact: Contact) {
        if let index = contacts.firstIndex(where: { $0.id == contact.id }) {
            contacts[index] = contact
        }
    }
    
    func saveContact(_ contact: Contact) {
        if let _ = self.contacts.first(where: { $0.id == contact.id }) {
            self.editContact(contact)
        } else {
            self.addContact(firstName: contact.firstName, lastName: contact.lastName, phoneNumber: contact.phoneNumber)
        }
    }
    
    func isvalidContact(_ contact: Contact) -> Bool {
        let isValid = !contact.firstName.isEmpty && !contact.lastName.isEmpty
        && isValidPhoneNumber(contact.phoneNumber)
//        self.validationResult = isValid
        return isValid
    }

    private func isValidPhoneNumber(_ phoneNumber: String) -> Bool {
        let phoneNumberPattern = "^\\(\\d{3}\\) ?\\d{3}-\\d{4}$"
        do {
            let regex = try NSRegularExpression(pattern: phoneNumberPattern)
            let range = NSRange(location: 0, length: phoneNumber.utf16.count)
            return regex.firstMatch(in: phoneNumber, options: [], range: range) != nil
        } catch
        {
            print("Invalid regex: \(error.localizedDescription)")
            return false
        }
    }
}
