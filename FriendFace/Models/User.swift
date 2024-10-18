import Foundation
import SwiftData

@Model
final class User: Codable {
    var id: UUID
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]

    @Relationship(inverse: \Friend.user)
    var friends: [Friend]

    init(
        id: UUID = UUID(),
        isActive: Bool = false,
        name: String = "",
        age: Int = 0,
        company: String = "",
        email: String = "",
        address: String = "",
        about: String = "",
        registered: Date = .distantPast,
        tags: [String] = [],
        friends: [Friend] = []
    ) {
        self.id = id
        self.isActive = isActive
        self.name = name
        self.age = age
        self.company = company
        self.email = email
        self.address = address
        self.about = about
        self.registered = registered
        self.tags = tags
        self.friends = friends
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.isActive = try container.decode(Bool.self, forKey: .isActive)
        self.name = try container.decode(String.self, forKey: .name)
        self.age = try container.decode(Int.self, forKey: .age)
        self.company = try container.decode(String.self, forKey: .company)
        self.email = try container.decode(String.self, forKey: .email)
        self.address = try container.decode(String.self, forKey: .address)
        self.about = try container.decode(String.self, forKey: .about)
        self.registered = try container.decode(Date.self, forKey: .registered)
        self.tags = try container.decode([String].self, forKey: .tags)
        self.friends = try container.decode([Friend].self, forKey: .friends)
    }

    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(isActive, forKey: .isActive)
        try container.encode(name, forKey: .name)
        try container.encode(age, forKey: .age)
        try container.encode(company, forKey: .company)
        try container.encode(email, forKey: .email)
        try container.encode(address, forKey: .address)
        try container.encode(about, forKey: .about)
        try container.encode(registered, forKey: .registered)
        try container.encode(tags, forKey: .tags)
        try container.encode(friends, forKey: .friends)
    }

    enum CodingKeys: String, CodingKey {
        case id
        case isActive
        case name
        case age
        case company
        case email
        case address
        case about
        case registered
        case tags
        case friends
    }
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

extension User {
    static func fetchDescriptor() -> FetchDescriptor<User> { FetchDescriptor() }
}
