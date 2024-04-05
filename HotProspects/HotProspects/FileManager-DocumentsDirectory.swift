//
//  FileManager-DocumentsDirectory.swift
//  Bucketlist
//
//  Created by Rotem Nevgauker on 11/11/2023.
//

import Foundation
extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
