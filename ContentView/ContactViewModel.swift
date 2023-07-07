//
//  ContactViewModel.swift
//  ContentView
//
//  Created by Luiza Poghosyan on 04.07.23.
//

import Foundation

// The ContactViewModel class is responsible for managing the contacts data and providing methods to add, delete, edit, and validate contacts.
class ContactViewModel: ObservableObject {
    @Published var contacts = [Contact]()
       
    // Add a new contact to the contacts array
    func addContact(firstName: String, lastName: String, phoneNumber: String) {
        let newContact = Contact(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber)
        contacts.append(newContact)
    }
       
    // Delete a contact from the contacts array
    func deleteContact(_ contact: Contact) {
        if let index = contacts.firstIndex(where: { $0.id == contact.id }) {
            contacts.remove(at: index)
        }
    }
       
    // Edit an existing contact in the contacts array
    func editContact(_ contact: Contact) {
        if let index = contacts.firstIndex(where: { $0.id == contact.id }) {
            contacts[index] = contact
        }
    }
    
    // Save a contact by either editing an existing contact or adding a new contact
    func saveContact(_ contact: Contact) {
        if let _ = self.contacts.first(where: { $0.id == contact.id }) {
            self.editContact(contact)
        } else {
            self.addContact(firstName: contact.firstName, lastName: contact.lastName, phoneNumber: contact.phoneNumber)
        }
    }
    
    // Check if a contact is valid by ensuring that the first name, last name, and phone number are not empty and the phone number matches a specific pattern
    func isvalidContact(_ contact: Contact) -> Bool {
        let isValid = !contact.firstName.isEmpty && !contact.lastName.isEmpty
        && isValidPhoneNumber(contact.phoneNumber)
        return isValid
    }

    // Check if a phone number matches a specific pattern using regular expressions
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
