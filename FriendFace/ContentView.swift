import SwiftUI

struct ContentView: View {
    @State private var users: [User] = []

    @State private var isShowingNetworkError = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(users) { user in
                    NavigationLink {
                        UserDetailView(user: user)
                    } label: {
                        VStack {
                            Text(user.name)
                                .font(.title3)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text(user.email)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
            }
            .navigationTitle("FriendFace")
        }
        .alert("An error has occurred", isPresented: $isShowingNetworkError) {
            Button("Ok") { }
        } message: {
            Text("Could not retrieve users.")
        }
    }
}

#Preview {
    ContentView()
}
