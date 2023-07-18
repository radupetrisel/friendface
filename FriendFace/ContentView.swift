//
//  ContentView.swift
//  FriendFace
//
//  Created by Radu Petrisel on 17.07.2023.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @StateObject private var viewModel = ContentViewModel()
    
    @State private var isShowingNetworkError = false
    
    @FetchRequest(sortDescriptors: []) private var users: FetchedResults<CachedUser>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.users) { user in
                    NavigationLink {
                        UserDetailView(contentViewModel: viewModel, user: user)
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
        .task {
            do {
                try await viewModel.loadUsers(viewContext: viewContext, cachedUsers: Array(users))
            } catch {
                isShowingNetworkError = true
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
