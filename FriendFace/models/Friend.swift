//
//  Friend.swift
//  FriendFace
//
//  Created by Radu Petrisel on 17.07.2023.
//

import CoreData
import Foundation

struct Friend: Identifiable, Codable {
    let id: UUID
    let name: String
}

extension Friend {
    init(_ cachedFriend: CachedFriend) {
        self.init(id: cachedFriend.id ?? UUID(), name: cachedFriend.name ?? "Unnamed")
    }
    
    func cache(using managedObjectContext: NSManagedObjectContext) -> CachedFriend {
        let cachedFriend = CachedFriend(context: managedObjectContext)
        cachedFriend.id = id
        cachedFriend.name = name
        
        return cachedFriend
    }
}
