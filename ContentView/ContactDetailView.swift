//
//  ContactDetailView.swift
//  ContentView
//
//  Created by Luiza Poghosyan on 04.07.23.
//

import Foundation
import SwiftUI

struct ContactDetailView: View {
    @ObservedObject var viewModel: ContactViewModel
    @Environment(\.presentationMode) var presentationMode
    @State var contact: Contact

    var isEdit: Bool

    var body: some View {
        NavigationView {
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

                SaveButtonView(viewModel: viewModel, contact: $contact, presentationMode: presentationMode)
                if isEdit {
                    DeleteButtonView(viewModel: viewModel, contact: $contact, presentationMode: presentationMode)
                }
            }
            .navigationBarTitle(isEdit ? "Edit Contact" : "New Contact")

        }
    }
}

struct SaveButtonView: View {
    @ObservedObject var viewModel: ContactViewModel
    @Binding var contact: Contact
    var presentationMode: Binding<PresentationMode>

    var body: some View {
        Button(action: {
            viewModel.saveContact(contact)
            presentationMode.wrappedValue.dismiss()
            
        }) {
            Text("Save")
        }
        .modifier(ResponsiveButtonStyleModifier(isValid: viewModel.isvalidContact(contact)))
//        .disabled(!viewModel.isvalidContact(contact))
    }
}


struct DeleteButtonView: View {
    @ObservedObject var viewModel: ContactViewModel
    @Binding var contact: Contact
    var presentationMode: Binding<PresentationMode>
    @State private var showDeleteAlert = false

    private func startDeleting() {
        viewModel.deleteContact(contact)
        presentationMode.wrappedValue.dismiss()
    }

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
                self.startDeleting()
            }, secondaryButton: .cancel())
        }
    }
}
