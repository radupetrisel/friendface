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
}

extension User {
    static let preview = User(
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
        friends: [
            Friend(id: UUID(), name: "Jane Doe"),
            Friend(id: UUID(), name: "John Johnson"),
        ]
    )
}
