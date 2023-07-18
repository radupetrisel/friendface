//
//  User.swift
//  FriendFace
//
//  Created by Radu Petrisel on 17.07.2023.
//

import CoreData
import Foundation

struct User: Identifiable, Codable {
    let id: UUID
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: Date
    let tags: [String]
    let friends: [Friend]
    
    var tagsInline: String {
        "#\(tags.joined(separator: " #"))"
    }
    
    static var preview: User {
        User(
            id: UUID(),
            isActive: true,
            name: "John Doe",
            age: 28,
            company: "Apple",
            email: "john.doe@email.com",
            address: "4, Swift Street, 784562",
            about: "I like helping devs test their data",
            registered: Date.now,
            tags: ["Awesome", "Friendly", "LikesDrinking"],
            friends: [Friend(id: UUID(), name: "Jane Doe"), Friend(id: UUID(), name: "John Johnson")]
        )
    }
}

extension User {
    init(_ cachedUser: CachedUser) {
        let cachedFriends = cachedUser.friends as? Set<CachedFriend>
        self.init(
            id: cachedUser.id ?? UUID(),
            isActive: cachedUser.isActive,
            name: cachedUser.name ?? "Unnamed",
            age: Int(cachedUser.age),
            company: cachedUser.company ?? "Unemployed",
            email: cachedUser.email ?? "N/A",
            address: cachedUser.address ?? "Homeless",
            about: cachedUser.about ?? "",
            registered: cachedUser.registered ?? Date.now,
            tags: cachedUser.tags?.components(separatedBy: " ") ?? [],
            friends: cachedFriends?.map { Friend($0) } ?? []
        )
    }
    
    func cache(using managedObjectContext: NSManagedObjectContext) -> CachedUser {
        let cachedUser = CachedUser(context: managedObjectContext)
        cachedUser.id = id
        cachedUser.name = name
        cachedUser.age = Int16(age)
        cachedUser.company = company
        cachedUser.email = email
        cachedUser.address = address
        cachedUser.about = about
        cachedUser.registered = registered
        cachedUser.tags = tags.joined(separator: " ")
        cachedUser.friends = NSSet(array: friends.map { $0.cache(using: managedObjectContext) })
        
        return cachedUser
    }
}
