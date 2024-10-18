import Foundation

@Observable
final class DataModel {
    private(set) var users = [User]()

    func loadUsers() async throws {
        guard users.isEmpty else {
            print("Users already loaded")
            return
        }

        print("Loading users from URL")

        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            fatalError("URL is invalid.")
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        users = try Self.decoder.decode([User].self, from: data)

        print("Users loaded successfully")
    }

    private static let decoder: JSONDecoder = makeDecoder()

    private static func makeDecoder() -> JSONDecoder {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601

        return jsonDecoder
    }
}
