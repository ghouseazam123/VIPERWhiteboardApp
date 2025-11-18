//
//  WhiteboardPresenter.swift
//  VIPERWhiteboardApp
//
//  Created by next on 05/11/25.
import SwiftUI
import Combine
import Foundation

enum DrawingTool {
    case pencil
    case eraser
}
@MainActor
final class WhiteboardPresenter: ObservableObject {
    @Published private(set) var strokes: [Stroke] = []
    @Published var currentStroke: Stroke = Stroke()
    @Published var selectedColor: String = "000000"
    @Published var selectedTool: DrawingTool = .pencil
    @Published var lineWidth: CGFloat = 3
    @Published var strokeOpacity: Double = 1.0

    private var undoneStrokes: [Stroke] = []
    private let interactor: WhiteboardInteractorInput
    private let router: WhiteboardRouter

    init(interactor: WhiteboardInteractorInput, router: WhiteboardRouter) {
        self.interactor = interactor
        self.router = router
        self.strokes = interactor.loadSavedStrokes()
    }

    func startStroke(at location: CGPoint) {
        let isEraser = selectedTool == .eraser
        currentStroke = Stroke(
            points: [StrokePoint(x: location.x, y: location.y)],
            colorHex: selectedColor,
            lineWidth: isEraser ? 20 : lineWidth,
            opacity: strokeOpacity,
            isEraser: isEraser
        )
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

    func clearCanvas() {
        interactor.clearAllStrokes()
        strokes = []
        undoneStrokes = []
    }

    func setTool(_ tool: DrawingTool) {
        selectedTool = tool
        lineWidth = (tool == .eraser) ? 20 : 3
    }

    func setColor(_ color: String) {
        selectedColor = color
        if selectedTool == .eraser {
            setTool(.pencil)
        }
    }

    func undoLastStroke() {
        guard !strokes.isEmpty else { return }
        undoneStrokes.append(strokes.removeLast())
    }

    func redoLastStroke() {
        guard !undoneStrokes.isEmpty else { return }
        strokes.append(undoneStrokes.removeLast())
    }

    var canUndo: Bool { !strokes.isEmpty }
    var canRedo: Bool { !undoneStrokes.isEmpty }

    // Presenter only calls router for navigation
    func onReferenceButtonTapped() {
        router.navigateToReferenceView()
    }

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


