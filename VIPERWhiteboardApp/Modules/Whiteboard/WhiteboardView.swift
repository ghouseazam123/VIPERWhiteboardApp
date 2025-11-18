//
//  WhiteboardView.swift
//  VIPERWhiteboardApp
//
//  Created by next on 05/11/25.
import SwiftUI

struct WhiteboardView: View {
    @ObservedObject var presenter: WhiteboardPresenter

    var body: some View {
        NavigationView {
            ZStack {
                Color.white.ignoresSafeArea()
                GeometryReader { geo in
                    ZStack {
                        ForEach(presenter.strokes) { stroke in
                            drawStroke(stroke)
                        }
                        drawStroke(presenter.currentStroke)
                    }
                    .compositingGroup()
                    .contentShape(Rectangle())
                    .gesture(drawingGesture(in: geo))
                }

                MovableToolbar(presenter: presenter)
            }
            .navigationTitle("Whiteboard")
            .navigationBarHidden(true)
        }
    }

    private func drawingGesture(in geo: GeometryProxy) -> some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { value in
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

    @ViewBuilder
    private func drawStroke(_ stroke: Stroke) -> some View {
        Path { path in
            guard let first = stroke.points.first else { return }
            path.move(to: CGPoint(x: first.x, y: first.y))
            for point in stroke.points.dropFirst() {
                path.addLine(to: CGPoint(x: point.x, y: point.y))
            }
        }
        .stroke(
            Color(hex: stroke.colorHex)
                .opacity(stroke.isEraser ? 1.0 : stroke.opacity),
            style: StrokeStyle(
                lineWidth: stroke.lineWidth,
                lineCap: .round,
                lineJoin: .round
            )
        )
        .blendMode(stroke.isEraser ? .destinationOut : .normal)
    }
}

struct WhiteboardView_Previews: PreviewProvider {
    static var previews: some View {
        WhiteboardView(presenter: createPresenter())
    }

    @MainActor
    static func createPresenter() -> WhiteboardPresenter {
        let interactor = WhiteboardInteractor()
        let router = WhiteboardRouter()
        return WhiteboardPresenter(interactor: interactor, router: router)
    }
}





