import SwiftUI

struct UserDetailView: View {
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
                
                NavigationLink {
                    Text(user.about)
                } label: {
                    Text("About")
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
                    userDetailText(user.registered.formatted(date: .abbreviated, time: .omitted))
                }
            }
            
            Section("Work") {
                HStack {
                    Text("Company")
                    Spacer()
                    userDetailText(user.company)
                }
            }
            
            Section("Tags") {
                HStack {
                    ForEach(user.tags, id: \.self) { tag in
                        Text(tag)
                    }
                }
            }
            
            Section("Friends") {
                ForEach(user.friends) { friend in
                    Text(friend.name)
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
