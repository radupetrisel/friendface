//
//  ContentViewModel.swift
//  FriendFace
//
//  Created by Radu Petrisel on 17.07.2023.
//

import SwiftUI

final class ContentViewModel: ObservableObject {
    private static let urlString = "https://www.hackingwithswift.com/samples/friendface.json"
    
    @Published private var usersById: [UUID: User] = [:]
    
    var users: [User] {
        Array(usersById.values)
    }
    
    func loadUsers() async throws {
        guard usersById.isEmpty else {
            return
        }
        
        guard let url = URL(string: Self.urlString) else {
            fatalError("Could not parse URL: \(Self.urlString)")
        }
        
        let request = URLRequest(url: url)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        let users = try jsonDecoder.decode([User].self, from: data)
        
        DispatchQueue.main.async { [unowned self] in
            for user in users {
                self.usersById[user.id] = user
            }
        }
    }
    
    func getUser(byId id: UUID) -> User? {
        usersById[id]
    }
}
