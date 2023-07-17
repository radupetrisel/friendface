//
//  UserDetailView.swift
//  FriendFace
//
//  Created by Radu Petrisel on 17.07.2023.
//

import SwiftUI

struct UserDetailView: View {
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
        }
        .navigationTitle(user.name)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func userDetailText(_ string: String) -> some View {
        Text(string)
            .foregroundStyle(.secondary)
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UserDetailView(user: User.preview)
        }
    }
}