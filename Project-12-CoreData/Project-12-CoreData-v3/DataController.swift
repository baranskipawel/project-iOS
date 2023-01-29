//
//  DataController.swift
//  Project-12-CoreData-v3
//
//  Created by Pawel Baranski on 24/01/2023.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Project-12-CoreData-v3")
    
    init(){
        container.loadPersistentStores { description, error in
            if error != nil {
                print("Failed")
                return
            }
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }
}
