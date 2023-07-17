//
//  UserDetailView.swift
//  FriendFace
//
//  Created by Radu Petrisel on 17.07.2023.
//

import SwiftUI

struct UserDetailView: View {
    @ObservedObject private var contentViewModel: ContentViewModel
    
    let user: User
    
    var body: some View {
        Form {
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
                userDetailText(user.tagsInline)
            }
            
            Section("Friends") {
                ForEach(user.friends) { friend in
                    NavigationLink {
                        if let friendUser = contentViewModel.getUser(byId: friend.id) {
                            UserDetailView(contentViewModel: contentViewModel, user: friendUser)
                        } else {
                            Text(friend.name)
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
    
    init(contentViewModel: ContentViewModel, user: User) {
        self.contentViewModel = contentViewModel
        self.user = user
    }
    
    private func userDetailText(_ string: String) -> some View {
        Text(string)
            .foregroundStyle(.secondary)
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UserDetailView(contentViewModel: ContentViewModel(), user: User.preview)
        }
    }
}
