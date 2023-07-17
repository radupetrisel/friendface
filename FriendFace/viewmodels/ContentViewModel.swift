//
//  ContentViewModel.swift
//  FriendFace
//
//  Created by Radu Petrisel on 17.07.2023.
//

import SwiftUI

final class ContentViewModel: ObservableObject {
    private static let urlString = "https://www.hackingwithswift.com/samples/friendface.json"
    
    @Published var users: [User] = []
    
    func loadUsers() async throws {
        guard let url = URL(string: Self.urlString) else {
            fatalError("Could not parse URL: \(Self.urlString)")
        }
        
        let request = URLRequest(url: url)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        let users = try jsonDecoder.decode([User].self, from: data)
        
        DispatchQueue.main.async { [unowned self] in
            self.users = users
        }
    }
}
