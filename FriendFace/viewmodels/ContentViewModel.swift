//
//  ContentViewModel.swift
//  FriendFace
//
//  Created by Radu Petrisel on 17.07.2023.
//

import CoreData
import SwiftUI

final class ContentViewModel: ObservableObject {
    private static let urlString = "https://www.hackingwithswift.com/samples/friendface.json"
    
    @Published private var usersById: [UUID: User] = [:]
    
    var users: [User] {
        Array(usersById.values)
    }
    
    func loadUsers(viewContext: NSManagedObjectContext, cachedUsers: [CachedUser]) async throws {
        guard usersById.isEmpty else {
            return
        }
        
        if cachedUsers.isEmpty {
            print("Loading users from the internet.")
            guard let url = URL(string: Self.urlString) else {
                fatalError("Could not parse URL: \(Self.urlString)")
            }
            
            let request = URLRequest(url: url)
            
            let (data, _) = try await URLSession.shared.data(for: request)
            
            let jsonDecoder = JSONDecoder()
            jsonDecoder.dateDecodingStrategy = .iso8601
            let users = try jsonDecoder.decode([User].self, from: data)
            
            let _ = users.map { $0.cache(using: viewContext) }
            
            try await MainActor.run {
                for user in users {
                    usersById[user.id] = user
                    try viewContext.save()
                }
            }
        } else {
            await MainActor.run {
                for cachedUser in cachedUsers {
                    let user = User(cachedUser)
                    usersById[user.id] = user
                }
            }
        }
    }
    
    func getUser(byId id: UUID) -> User? {
        usersById[id]
    }
}
