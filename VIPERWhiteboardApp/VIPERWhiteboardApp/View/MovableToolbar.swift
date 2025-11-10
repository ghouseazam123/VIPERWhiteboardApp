//
//  MovableToolbar.swift
//  VIPERWhiteboardApp
//
//  Created by next on 07/11/25.
//
// MovableToolbar.swift
import SwiftUI

struct MovableToolbar: View {
    @ObservedObject var presenter: WhiteboardPresenter
    @State private var offset = CGSize.zero
    @GestureState private var dragOffset = CGSize.zero

    var body: some View {
        VStack {
            Spacer()
            HStack(spacing: 25) {
                // Pencil
                Button {
                    presenter.setTool(.pencil)
                } label: {
                    Image(systemName: "pencil.tip")
                        .font(.title)
                        .foregroundColor(presenter.selectedTool == .pencil ? .blue : .black)
                }

                // Eraser
                Button {
                    presenter.setTool(.eraser)
                } label: {
                    Image(systemName: "eraser")
                        .font(.title)
                        .foregroundColor(presenter.selectedTool == .eraser ? .blue : .black)
                }

                // Color Picker
                ColorPicker("", selection: Binding(
                    get: { Color(hex: presenter.selectedColor) },
                    set: { newColor in presenter.setColor(newColor.toHex()) }
                ))
                .labelsHidden()
                .frame(width: 35, height: 35)
                .clipShape(Circle())

                // Clear Canvas
                Button {
                    presenter.clearCanvas()
                } label: {
                    Image(systemName: "trash")
                        .font(.title)
                        .foregroundColor(.red)
                }
            }
            .padding()
            .background(Color.white.opacity(0.9))
            .cornerRadius(20)
            .shadow(radius: 5)
            .offset(x: offset.width + dragOffset.width, y: offset.height + dragOffset.height)
            .gesture(
                DragGesture()
                    .updating($dragOffset) { value, state, _ in
                        state = value.translation
                    }
                    .onEnded { value in
                        offset.width += value.translation.width
                        offset.height += value.translation.height
                    }
            )
        }
        .padding(.bottom, 15)
    }
}

// MARK: - Preview
struct MovableToolbar_Previews: PreviewProvider {
    static var previews: some View {
        let interactor = WhiteboardInteractor()
        let router = WhiteboardRouter()
        let presenter = WhiteboardPresenter(interactor: interactor, router: router)
        MovableToolbar(presenter: presenter) // ✅ Removed showSavedToast
    }
}




