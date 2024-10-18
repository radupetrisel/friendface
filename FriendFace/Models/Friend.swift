import Foundation
import SwiftData

@Model
final class Friend: Codable {
    var id: UUID
    var name: String

    @Relationship
    var user: User?

    init(id: UUID = UUID(), name: String = "") {
        self.id = id
        self.name = name
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
    }

    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
    }

    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}
