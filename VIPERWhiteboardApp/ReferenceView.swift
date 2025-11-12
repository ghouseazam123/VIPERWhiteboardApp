//
//  ReferenceView.swift
//  VIPERWhiteboardApp
//
//  Created by next on 10/11/25.
//
import SwiftUI

struct ReferenceView: View {
//    private let referenceURL = URL(string: "https://picsum.photos/400/300")!
    private let referenceURL = URL(string: "https://fastly.picsum.photos/id/13/2500/1667.jpg?hmac=SoX9UoHhN8HyklRA4A3vcCWJMVtiBXUg0W4ljWTor7s")!
    @State private var showError = false

    var body: some View {
        NavigationView {
            VStack {
                AsyncImage(url: referenceURL) { phase in
                    switch phase {
                    case .empty:
                        ProgressView("Loading...")
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(12)
                            .padding()
                    case .failure(_):
                        Text("Failed to load image")
                            .foregroundColor(.red)
                    @unknown default:
                        EmptyView()
                    }
                }
                Spacer()
            }
            .alert("Error", isPresented: $showError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Failed to load reference image.")
            }
            .navigationTitle("Reference Drawing")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}






struct ReferenceView_Previews: PreviewProvider {
    static var previews: some View {
        ReferenceView()
    }
}
