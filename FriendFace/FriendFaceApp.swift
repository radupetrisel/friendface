//
//  FriendFaceApp.swift
//  FriendFace
//
//  Created by Radu Petrisel on 17.07.2023.
//

import SwiftUI

@main
struct FriendFaceApp: App {
    private let dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.viewContext)
        }
    }
}
