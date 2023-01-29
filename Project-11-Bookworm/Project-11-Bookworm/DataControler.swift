//
//  DataControler.swift
//  Project-11-Bookworm
//
//  Created by Pawel Baranski on 23/01/2023.
//

import Foundation
import CoreData

class DataControler : ObservableObject {
    let container = NSPersistentContainer(name: "Bookworm") //use our core data
    
    
    init() {
        container.loadPersistentStores{
            description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
