//
//  FileManager-DocumentDirectory.swift
//  Project-14-BucketList
//
//  Created by Pawel Baranski on 28/01/2023.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
