import XCTest
@testable import ContentView

class ContactViewModelTests: XCTestCase {
    var viewModel: ContactViewModel!

    override func setUp() {
        super.setUp()
        viewModel = ContactViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testAddContact() {
        let newContact = Contact(firstName: "Test", lastName: "User", phoneNumber: "(123) 456-7890")
        viewModel.addContact(firstName: newContact.firstName, lastName: newContact.lastName, phoneNumber: newContact.phoneNumber)
        XCTAssertTrue(viewModel.contacts.contains { $0.firstName == newContact.firstName && $0.lastName == newContact.lastName && $0.phoneNumber == newContact.phoneNumber })
    }

    func testDeleteContact() {
        let newContact = Contact(firstName: "Test", lastName: "User", phoneNumber: "(123) 456-7890")
        viewModel.addContact(firstName: newContact.firstName, lastName: newContact.lastName, phoneNumber: newContact.phoneNumber)
        viewModel.deleteContact(newContact)
        XCTAssertFalse(viewModel.contacts.contains { $0.id == newContact.id })
    }

    func testEditContact() {
        var newContact = Contact(firstName: "Test", lastName: "User", phoneNumber: "(123) 456-7890")
        viewModel.addContact(firstName: newContact.firstName, lastName: newContact.lastName, phoneNumber: newContact.phoneNumber)
        newContact.firstName = "Edited"
        viewModel.editContact(newContact)
        XCTAssertFalse(viewModel.contacts.contains { $0.firstName == "Edited" })
    }

    func testSaveContact() {
        let newContact = Contact(firstName: "Test", lastName: "User", phoneNumber: "(123) 456-7890")
        viewModel.saveContact(newContact)
        XCTAssertTrue(viewModel.contacts.contains { $0.firstName == newContact.firstName && $0.lastName == newContact.lastName && $0.phoneNumber == newContact.phoneNumber })
        var editedContact = newContact
        editedContact.firstName = "Edited"
        viewModel.saveContact(editedContact)
        XCTAssertTrue(viewModel.contacts.contains { $0.firstName == "Edited" && $0.lastName == newContact.lastName && $0.phoneNumber == newContact.phoneNumber })
    }

    func testIsValidContact() {
        let validContact = Contact(firstName: "Test", lastName: "User", phoneNumber: "(123) 456-7890")
        XCTAssertTrue(viewModel.isvalidContact(validContact))
        let invalidContact = Contact(firstName: "", lastName: "", phoneNumber: "1234567890")
        XCTAssertFalse(viewModel.isvalidContact(invalidContact))
    }
}
