//
//  WhiteboardPresenter.swift
//  VIPERWhiteboardApp
//
//  Created by next on 05/11/25.
//

// WhiteboardPresenter.swift
import Foundation
import Combine
import SwiftUI

enum DrawingTool {
    case pencil
    case eraser
}

final class WhiteboardPresenter: ObservableObject {
    @Published private(set) var strokes: [Stroke] = []
    @Published var currentStroke: Stroke = Stroke()
    @Published var selectedColor: String = "000000"
    @Published var selectedTool: DrawingTool = .pencil
    @Published var lineWidth: CGFloat = 3

    private let interactor: WhiteboardInteractorInput
    private let router: WhiteboardRouter

    init(interactor: WhiteboardInteractorInput, router: WhiteboardRouter) {
        self.interactor = interactor
        self.router = router
        self.strokes = interactor.loadSavedStrokes()
    }

    func startStroke(at location: CGPoint) {
        let colorHex = (selectedTool == .eraser) ? "FFFFFF" : selectedColor
        currentStroke = Stroke(points: [StrokePoint(x: location.x, y: location.y)],
                               colorHex: colorHex,
                               lineWidth: lineWidth)
    }

    func continueStroke(at location: CGPoint) {
        currentStroke.points.append(StrokePoint(x: location.x, y: location.y))
        objectWillChange.send()
    }

    func endStroke() {
        guard !currentStroke.points.isEmpty else {
            currentStroke = Stroke()
            return
        }
        strokes.append(currentStroke)
        interactor.saveStrokes(strokes)
        currentStroke = Stroke()
    }
    func saveCanvas() {
        interactor.saveStrokes(strokes)
    }


    func clearCanvas() {
        interactor.clearAllStrokes()
        strokes = []
    }

    func setTool(_ tool: DrawingTool) {
        selectedTool = tool
        if tool == .eraser {
            lineWidth = 15
            selectedColor = "FFFFFF"
        } else {
            lineWidth = 3
            if selectedColor.uppercased() == "FFFFFF" {
                selectedColor = "000000"
            }
        }
    }

    func setColor(_ color: String) {
        selectedColor = color
        if selectedTool == .eraser {
            selectedTool = .pencil
            lineWidth = 3
        }
    }
}




