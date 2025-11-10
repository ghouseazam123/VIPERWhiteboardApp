//
//  Stroke.swift
//  VIPERWhiteboardApp
//
//  Created by next on 05/11/25.
//
// Stroke.swift
import Foundation
import CoreGraphics

struct StrokePoint: Codable {
    var x: CGFloat
    var y: CGFloat
}

struct Stroke: Identifiable, Codable {
    let id: UUID
    var points: [StrokePoint]
    var colorHex: String
    var lineWidth: CGFloat

    init(id: UUID = UUID(),
         points: [StrokePoint] = [],
         colorHex: String = "000000",
         lineWidth: CGFloat = 3) {
        self.id = id
        self.points = points
        self.colorHex = colorHex
        self.lineWidth = lineWidth
    }
}


