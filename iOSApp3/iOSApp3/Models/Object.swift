//
//  Object.swift
//  iOSApp3
//
//  Created by Tassos Fergadiotis on 2025-02-23.
//

import Foundation

struct Object: Codable, Hashable {
    let objectID: Int
    let title: String
    let creditLine: String
    let objectURL: String
    let isPublicDomain: Bool
    let primaryImageSmall: String
}

struct ObjectIDs: Codable {
    let total: Int
    let objectIDs: [Int]
}
