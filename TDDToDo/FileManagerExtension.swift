//
//  FileManagerExtension.swift
//  ToDo-UIKit
//
//  Created by Spencer Jones on 1/20/24.
//

import Foundation

extension FileManager {
    func documentsURL(name: String) -> URL {
        guard let documentsURL = urls(for: .documentDirectory, in: .userDomainMask)
            .first else {
                fatalError()
            }
        return documentsURL.appendingPathComponent(name)
    }
}
