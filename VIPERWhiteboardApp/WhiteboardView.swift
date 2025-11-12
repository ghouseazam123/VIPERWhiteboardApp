//
//  WhiteboardView.swift
//  VIPERWhiteboardApp
//
//  Created by next on 05/11/25.
import SwiftUI

struct WhiteboardView: View {
    @ObservedObject var presenter: WhiteboardPresenter
    @State private var navigateTo: AnyView? = nil

    var body: some View {
        NavigationView {
            ZStack {
                Color.white.ignoresSafeArea()

                GeometryReader { geo in
                    ZStack {
                        ForEach(presenter.strokes) { stroke in drawStroke(stroke) }
                        drawStroke(presenter.currentStroke)
                    }
                    .contentShape(Rectangle())
                    .gesture(drawingGesture(in: geo))
                }
                .coordinateSpace(name: "canvas")

                MovableToolbar(presenter: presenter)

                // Reference button
                VStack {
                    HStack {
                        Spacer()
                        Button(action: { navigateTo = presenter.goToReferenceView() }) {
                            Image(systemName: "photo.on.rectangle")
                                .font(.title2)
                                .padding(10)
                                .background(Color.black.opacity(0.1))
                                .clipShape(Circle())
                        }
                        .padding(.top, 40)
                        .padding(.trailing, 20)
                    }
                    Spacer()
                }

                NavigationLink(destination: navigateTo,
                               isActive: Binding(get: { navigateTo != nil }, set: { if !$0 { navigateTo = nil } })) {
                    EmptyView()
                }
            }
            .navigationTitle("Whiteboard")
            .navigationBarTitleDisplayMode(.inline)
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
            .onEnded { _ in presenter.endStroke() }
    }

    private func drawStroke(_ stroke: Stroke) -> some View {
        Path { path in
            guard let first = stroke.points.first else { return }
            path.move(to: CGPoint(x: first.x, y: first.y))
            for point in stroke.points.dropFirst() {
                path.addLine(to: CGPoint(x: point.x, y: point.y))
            }
        }
        .stroke(Color(hex: stroke.colorHex).withOpacity(stroke.opacity),
                style: StrokeStyle(lineWidth: stroke.lineWidth,
                                   lineCap: .round,
                                   lineJoin: .round))
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

