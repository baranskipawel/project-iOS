//
//  Project_11_BookwormApp.swift
//  Project-11-Bookworm
//
//  Created by Pawel Baranski on 23/01/2023.
//

import SwiftUI

@main
struct Project_11_BookwormApp: App {
    
    @StateObject private var dataController = DataControler()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
            //connect core data
        }
    }
}
