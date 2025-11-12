//
//  MovableToolbar.swift
//  VIPERWhiteboardApp
//
//  Created by next on 07/11/25.
import SwiftUI

struct MovableToolbar: View {
    @ObservedObject var presenter: WhiteboardPresenter
    @State private var offset = CGSize.zero
    @GestureState private var dragOffset = CGSize.zero

    @State private var showClearAlert = false
    @State private var showSaveAlert = false

    var body: some View {
        VStack {
            Spacer()
            HStack(spacing: 15) {
                // ✏️ Pencil
                Button { presenter.setTool(.pencil) } label: {
                    Image(systemName: "pencil.tip")
                        .font(.title)
                        .foregroundColor(presenter.selectedTool == .pencil ? .blue : .black)
                }

                // 🧽 Eraser
                Button { presenter.setTool(.eraser) } label: {
                    Image(systemName: "eraser")
                        .font(.title)
                        .foregroundColor(presenter.selectedTool == .eraser ? .blue : .black)
                }

                // Undo
                Button { presenter.undoLastStroke() } label: {
                    Image(systemName: "arrow.uturn.backward")
                        .foregroundColor(presenter.canUndo ? .blue : .gray)
                }
                .disabled(!presenter.canUndo)

                // Redo
                Button { presenter.redoLastStroke() } label: {
                    Image(systemName: "arrow.uturn.forward")
                        .foregroundColor(presenter.canRedo ? .blue : .gray)
                }
                .disabled(!presenter.canRedo)

                // 🎨 Color Picker
                ColorPicker("", selection: Binding(
                    get: { Color(hex: presenter.selectedColor).withOpacity(presenter.strokeOpacity) },
                    set: { newColor in
                        let (hex, alpha) = newColor.toHexWithAlpha()
                        presenter.setColor(hex)
                        presenter.strokeOpacity = alpha
                    }
                ))
                .labelsHidden()
                .frame(width: 35, height: 35)
                .clipShape(Circle())

                // 🗑 Clear
                Button { showClearAlert = true } label: {
                    Image(systemName: "trash").foregroundColor(.red)
                }

                // 💾 Save
                Button { presenter.saveCanvas(); showSaveAlert = true } label: {
                    Image(systemName: "square.and.arrow.down").foregroundColor(.green)
                }
            }
            .padding()
            .background(Color.white.opacity(0.9))
            .cornerRadius(20)
            .shadow(radius: 5)
            .offset(x: offset.width + dragOffset.width,
                    y: offset.height + dragOffset.height)
            .gesture(
                DragGesture()
                    .updating($dragOffset) { value, state, _ in state = value.translation }
                    .onEnded { value in offset.width += value.translation.width; offset.height += value.translation.height }
            )
            .alert("Confirm Clear", isPresented: $showClearAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Clear", role: .destructive) { presenter.clearCanvas() }
            } message: { Text(presenter.confirmClearCanvas()) }
            .alert("✅ Saved", isPresented: $showSaveAlert) {
                Button("OK", role: .cancel) { }
            } message: { Text(presenter.saveConfirmationMessage()) }
        }
        .padding(.bottom, 15)
    }
}



struct MovableToolbar_Previews: PreviewProvider {
    static var previews: some View {
        let interactor = WhiteboardInteractor()
        let router = WhiteboardRouter()
        let presenter = WhiteboardPresenter(interactor: interactor, router: router)
        MovableToolbar(presenter: presenter)
    }
}








