//
//  DataController.swift
//  FriendFace
//
//  Created by Radu Petrisel on 18.07.2023.
//

import CoreData

final class DataController {
    let viewContext: NSManagedObjectContext
    
    init() {
        let container = NSPersistentContainer(name: "FriendFace")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Could not initialize CoreData. \(error.localizedDescription)")
            }
        }
        
        viewContext = container.viewContext
    }
}
