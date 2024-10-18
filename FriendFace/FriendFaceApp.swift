import SwiftData
import SwiftUI

@main
struct FriendFaceApp: App {
    private let dataModel = DataModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(dataModel)
                .modelContainer(for: User.self)
        }
    }
}
