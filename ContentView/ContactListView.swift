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
    @State var showToast = false
    

    var body: some View {
        NavigationView {
            VStack {
                contactListView
                addContactLink
                
                if showToast {
                    toastView
                }
            }.background(Color(red: 235/255, green: 0/255, blue: 0/255))
        }
    }
    
    // The contactListView displays the list of contacts
    private var contactListView: some View {
        Form {
            Text("List up to four people we can call upon your request in the event of an emergency.")
                .foregroundColor(.black)
            ForEach(viewModel.contacts) { contact in
                NavigationLink(destination: ContactDetailView(viewModel: viewModel, contact: contact, isEdit: true)) {
                    ContactRow(contact: contact)
                }
            }
            .lineSpacing(5)
            .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
        }
        .navigationBarTitle("Contacts")
    }
    
    // The toastView displays a status message at the bottom of the screen.
    private var toastView: some View {
        StatusView()
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    showToast = false
                }
            }
    }
    
    // The addContactLink is a navigation link that takes the user to the ContactDetailView to add a new contact.
    private var addContactLink: some View {
        NavigationLink(destination: {
            ContactDetailView(viewModel: viewModel, contact: Contact(), isEdit: false)
        }, label: {
            Label("Add Contact", systemImage: "plus").modifier(ResponsiveButtonStyleModifier(isValid: true))
        })
    }
    
    // The hideToastAfterDelay function hides the toast message after a specified delay.
    private func hideToastAfterDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + toastDisplayDuration) {
            showToast = false
        }
    }
}

// The ContactRow view displays a single contact in the contactListView.
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

// The StatusView displays a status message at the bottom of the screen.
struct StatusView: View {
    var body: some View {
        HStack {
            Text("Emergency contact created successfully")
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
        .frame(maxWidth: UIScreen.main.bounds.width * 0.75)
        .background(Color.black.opacity(0.7))
        .foregroundColor(.white)
        .cornerRadius(20)
        .transition(.move(edge: .bottom))
        .animation(.easeInOut(duration: 0.5))
    }
}
