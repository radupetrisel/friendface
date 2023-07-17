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
                ForEach(viewModel.users) {
                    Text($0.name)
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
