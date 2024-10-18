import SwiftData
import SwiftUI

struct UserDetailView: View {
    @Environment(\.modelContext) var modelContext

    let user: User

    var body: some View {
        List {
            Section("Personal info") {
                HStack {
                    Text("Age")
                    Spacer()
                    userDetailText("\(user.age)")
                }

                HStack {
                    Text("Address")
                    Spacer()
                    userDetailText(user.address)
                        .multilineTextAlignment(.trailing)
                }

                HStack {
                    Text("Email")
                    Spacer()
                    userDetailText(user.email)
                }
            }

            Section("Status") {
                HStack {
                    Text("Active")
                    Spacer()
                    userDetailText(user.isActive ? "Yes" : "No")
                }

                HStack {
                    Text("Member since")
                    Spacer()
                    userDetailText(
                        user.registered.formatted(date: .abbreviated, time: .omitted))
                }
            }

            Section("Work") {
                HStack {
                    Text("Company")
                    Spacer()
                    userDetailText(user.company)
                }
            }

            Section {
                Text(user.about)
            } header: {
                Text("About")
            } footer: {
                Text(user.tags.map { "#\($0)" }.joined(separator: " "))
            }

            Section("Friends") {
                ForEach(user.friends) { friend in
                    NavigationLink {
                        let userId = friend.id
                        let user = try? modelContext.fetch(User.fetchDescriptor())
                            .first(where: { $0.id == userId })

                        if let user {
                            UserDetailView(user: user)
                        } else {
                            Text("Could not find user for given ID.")
                        }
                    } label: {
                        Text(friend.name)
                    }
                }
            }
        }
        .navigationTitle(user.name)
        .navigationBarTitleDisplayMode(.inline)
    }

    private func userDetailText(_ string: String) -> some View {
        Text(string)
            .foregroundStyle(.secondary)
    }
}

#Preview {
    NavigationStack {
        UserDetailView(user: .preview)
    }
}
