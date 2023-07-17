//
//  User.swift
//  FriendFace
//
//  Created by Radu Petrisel on 17.07.2023.
//

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
