//
//  FileManager-DocumentsDirectory.swift
//  PhotoNamer
//
//  Created by Daniel Camarena on 10/1/23.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

