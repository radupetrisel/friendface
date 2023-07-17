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
}
