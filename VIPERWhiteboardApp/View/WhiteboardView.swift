//
//  WhiteboardView.swift
//  VIPERWhiteboardApp
//
//  Created by next on 05/11/25.
//

import SwiftUI
struct WhiteboardView: View {
    @ObservedObject var presenter: WhiteboardPresenter

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            // Canvas area - we'll name this coordinate space "canvas"
            GeometryReader { geo in
                ZStack {
                    // Existing strokes (draw in order)
                    ForEach(presenter.strokes) { stroke in
                        drawStroke(stroke)
                    }

                    // Current stroke on top so user sees it live
                    drawStroke(presenter.currentStroke)
                }
                .contentShape(Rectangle()) // make the whole area hittable
                .gesture(drawingGesture(in: geo)) // attach gesture to the canvas
            }
            .coordinateSpace(name: "canvas")

            // Movable Toolbar
            MovableToolbar(presenter: presenter)
        }
    }

    // Create a DragGesture that uses the local coordinate space of the GeometryReader
    private func drawingGesture(in geo: GeometryProxy) -> some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { value in
                // convert the location to the canvas local coordinates
                // value.location is already local to the view the gesture is attached to,
                // but using the geometry allows consistent results if you need absolute sizes.
                let loc = value.location
                if presenter.currentStroke.points.isEmpty {
                    presenter.startStroke(at: loc)
                } else {
                    presenter.continueStroke(at: loc)
                }
            }
            .onEnded { _ in
                presenter.endStroke()
            }
    }

    private func drawStroke(_ stroke: Stroke) -> some View {
        Path { path in
            guard let first = stroke.points.first else { return }
            path.move(to: CGPoint(x: first.x, y: first.y))
            for point in stroke.points.dropFirst() {
                path.addLine(to: CGPoint(x: point.x, y: point.y))
            }
        }
        .stroke(Color(hex: stroke.colorHex),
                style: StrokeStyle(lineWidth: stroke.lineWidth, lineCap: .round, lineJoin: .round))
    }
}



// MARK: - Preview
struct WhiteboardView_Previews: PreviewProvider {
    static var previews: some View {
        let interactor = WhiteboardInteractor()
        let router = WhiteboardRouter()
        let presenter = WhiteboardPresenter(interactor: interactor, router: router)
        WhiteboardView(presenter: presenter)
    }
}





