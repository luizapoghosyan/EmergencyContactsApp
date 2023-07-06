//
//  ContactListView.swift
//  ContentView
//
//  Created by Luiza Poghosyan on 04.07.23.
//

import Foundation
import SwiftUI

// Constants
let toastDisplayDuration: Double = 5

struct ContactList: View {
    init(viewModel: ContactViewModel) {
        self.viewModel = viewModel
    }
    
    
    @ObservedObject var viewModel: ContactViewModel
    @State private var showAddContact = false
    @State var toastMessage: String? = nil
    
    
    var body: some View {
        NavigationStack {
            VStack {
        
                contactListView
                if let msg = toastMessage {
                    StatusView(toastMessage: msg)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                toastMessage = nil
                            }
                        }
                }
                addContactButton
            }
            .navigationBarTitle("Contacts")
            .navigationDestination(isPresented: $showAddContact) {
                ContactDetailView(viewModel: viewModel, contact: Contact(), isEdit: false) { isDeleteAction in
                    assert(!isDeleteAction, "This flaw can't delete contact")
                    toastMessage = "Successfully added"
                }
            }.onAppear {
                showAddContact = false
            }
        }
        
    }
    
    private var contactListView: some View {
        Form {
            Text("List up to four people we can call upon your request in the event of an emergency.")
                .foregroundColor(.black)
            ForEach(viewModel.contacts) { contact in
                NavigationLink(destination: {
                    ContactDetailView(viewModel: viewModel, contact: contact, isEdit: true) { isDeleteAction in
                        toastMessage = isDeleteAction ? "Successfully deleted": "Successfully edited"
                    }
                    
                }) {
                    ContactRow(contact: contact)
                }
            }
            .lineSpacing(5)
            .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
        }
        
    }
    
    private var addContactButton: some View {
        Button(action: {
            showAddContact = true
        }) {
            Label("Add Contact", systemImage: "plus")
        }
        .buttonStyle(ResponsiveButtonStyle(disabled: false))
    }
    
    private func hideToastAfterDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + toastDisplayDuration) {
            toastMessage = nil
        }
    }
}

struct ContactRow: View {
    let contact: Contact
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(contact.fullName)")
                .foregroundColor(.black)
                .fontWeight(.bold)
                .font(.system(size: 15))
                .opacity(0.8)
            Text("\(contact.phoneNumber)")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
}

struct StatusView: View {
    var toastMessage: String
    var body: some View {
        HStack {
            Text(toastMessage)
                .font(.headline)
            Image("success")
                .resizable()
                .frame(width: 25, height: 25)
                .clipShape(Circle())
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.white, lineWidth: 2)
                )
        }
        .padding()
        .frame(maxWidth: UIScreen.main.bounds.width)
        .background(Color.black.opacity(0.7))
        .foregroundColor(.white)
        .transition(.move(edge: .bottom))
    }
}
