import SwiftUI
import Combine


struct ContentView: View {
    @StateObject var contacts = ContactViewModel()
    var body: some View {
        ContactList(viewModel: contacts)
    }
}
