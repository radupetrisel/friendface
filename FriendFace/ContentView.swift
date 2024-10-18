import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(DataModel.self) var dataModel

    @State private var isShowingNetworkError = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(dataModel.users) { user in
                    NavigationLink {
                        UserDetailView(user: user)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(user.name)
                                .font(.title3)
                            
                            Text(user.email)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
            .navigationTitle("FriendFace")
            .alert("An error has occurred", isPresented: $isShowingNetworkError) {
                Button("Ok") { }
            } message: {
                Text("Could not retrieve users.")
            }
            .task { @MainActor in
                do {
                    try await dataModel.loadUsers(into: modelContext)
                } catch {
                    isShowingNetworkError.toggle()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
