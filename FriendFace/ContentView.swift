//
//  ContentView.swift
//  FriendFace
//
//  Created by Radu Petrisel on 17.07.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    
    @State private var isShowingNetworkError = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.users) { user in
                    NavigationLink {
                        Text(user.address)
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
                try await viewModel.loadUsers()
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
