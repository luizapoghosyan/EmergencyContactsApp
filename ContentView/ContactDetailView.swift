//
//  ContactDetailView.swift
//  ContentView
//
//  Created by Luiza Poghosyan on 04.07.23.
//

import Foundation
import SwiftUI

// This view represents the detail view for a contact
struct ContactDetailView: View {
    @ObservedObject var viewModel: ContactViewModel
    @Environment(\.presentationMode) var presentationMode
    @State var contact: Contact
    @State var showLoading: Bool = false
    var isEdit: Bool
    var onEditingCompleated: (_ isDeleteAction: Bool) -> Void
    
    var pageContent: some View {
        VStack {
            Form {
                Section(header: Text("First Name")) {
                    TextField("Luiza", text: $contact.firstName)
                }
                Section(header: Text("Last Name")) {
                    TextField("Poghosyan", text: $contact.lastName)
                }
                Section(header: Text("Phone")) {
                    UIKitTextField(mask: "(XXX) XXX-XXXX", placeholder: "(111) 111-1111", text: $contact.phoneNumber)
                }
            }
            
            // Save button
            SaveButtonView(disabled: !viewModel.isvalidContact(contact)) {
                viewModel.saveContact(contact)
                emulateLoading(isDeleteAction: false)
            }
            // Delete button (only if in edit mode)
            if isEdit {
                DeleteButtonView() {
                    viewModel.deleteContact(contact)
                    emulateLoading(isDeleteAction: true)
                }
            }
        }
    }
    
    // Function to show a loading spinner for a while
    func emulateLoading(isDeleteAction: Bool) {
        showLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            showLoading = false
            presentationMode.wrappedValue.dismiss()
            onEditingCompleated(isDeleteAction)
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .center) {
                pageContent
                // Show loading spinner if loading
                if showLoading {
                    ProgressView() {
                        Text("Loading")
                    }.frame(alignment: .center)
                }
            }
        }
        // Set the navigation bar title based on whether it's in edit mode or not
        .navigationBarTitle(isEdit ? "Edit Contact" : "New Contact")
        
    }
}

// This view represents the save button
struct SaveButtonView: View {
    var disabled: Bool
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text("Save")
        }
        .buttonStyle(ResponsiveButtonStyle(disabled: disabled))
    }
}

// This view represents the delete button
struct DeleteButtonView: View {
    var delateAction: () -> Void
    @State private var showDeleteAlert = false

    var body: some View {
        Button(action: {
            self.showDeleteAlert = true
        }) {
            Text("Delete Contact")
        }
        .font(.headline)
        .foregroundColor(.red)
        .alert(isPresented: $showDeleteAlert) {
            Alert(title: Text("Are you sure you want to delete this contact?"), primaryButton: .destructive(Text("Delete")) {
                delateAction()
            }, secondaryButton: .cancel())
        }
    }
}
