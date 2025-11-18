//
//  ReferenceImage.swift
//  VIPERWhiteboardApp
//
//  Created by next on 12/11/25.
//

import Foundation

struct ReferenceImage: Identifiable, Codable {
    let id: String
    let author: String
    let width: Int
    let height: Int
    let url: String
    let download_url: String
}




