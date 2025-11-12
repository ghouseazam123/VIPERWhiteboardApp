//
//  WhiteboardPresenter.swift
//  VIPERWhiteboardApp
//
//  Created by next on 05/11/25.
import Foundation
import SwiftUI
import Combine

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
    @Published var strokeOpacity: Double = 1.0

    private var undoneStrokes: [Stroke] = []
    let interactor: WhiteboardInteractorInput
    private let router: WhiteboardRouter

    init(interactor: WhiteboardInteractorInput, router: WhiteboardRouter) {
        self.interactor = interactor
        self.router = router
        self.strokes = interactor.loadSavedStrokes()
    }

    // MARK: - Drawing Logic
    func startStroke(at location: CGPoint) {
        let colorHex = (selectedTool == .eraser) ? "FFFFFF" : selectedColor
        currentStroke = Stroke(points: [StrokePoint(x: location.x, y: location.y)],
                               colorHex: colorHex,
                               lineWidth: lineWidth,
                               opacity: strokeOpacity)
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

    // MARK: - Toolbar Actions
    func clearCanvas() {
        interactor.clearAllStrokes()
        strokes = []
        undoneStrokes = []
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

    // MARK: - Navigation
    func goToReferenceView() -> AnyView {
        return router.navigateToReferenceView()
    }

    // MARK: - Undo / Redo
    func undoLastStroke() {
        guard !strokes.isEmpty else { return }
        let last = strokes.removeLast()
        undoneStrokes.append(last)
    }

    func redoLastStroke() {
        guard !undoneStrokes.isEmpty else { return }
        let redoStroke = undoneStrokes.removeLast()
        strokes.append(redoStroke)
    }

    var canUndo: Bool { !strokes.isEmpty }
    var canRedo: Bool { !undoneStrokes.isEmpty }

    // MARK: - Alert Helpers
    func confirmClearCanvas() -> String {
        "Are you sure you want to clear the canvas? This action cannot be undone."
    }

    func saveConfirmationMessage() -> String {
        "Canvas saved successfully!"
    }

    func saveCanvas() {
        interactor.saveStrokes(strokes)
        print("✅ Canvas saved")
    }
}







