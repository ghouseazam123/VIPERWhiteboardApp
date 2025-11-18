//
//  ReferenceView.swift
//  VIPERWhiteboardApp
//
//  Created by next on 10/11/25.
//

import SwiftUI

struct ReferenceListView: View {
    @StateObject var presenter: ReferencePresenter
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                ForEach(presenter.images) { image in
                    AsyncImage(url: URL(string: image.download_url)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView().frame(height: 200)
                        case .success(let img):
                            img.resizable()
                                .scaledToFit()
                                .frame(height: 200)
                                .clipped()
                        case .failure:
                            VStack {
                                Image(systemName: "photo")
                                Text("Failed to load")
                            }
                            .frame(height: 200)
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .cornerRadius(10)
                    .shadow(radius: 2)
                    .padding(.horizontal)
                }
            }
            .padding(.vertical)
        }
        .navigationTitle("Reference Images")
        .alert("Error", isPresented: Binding(
            get: { presenter.errorMessage != nil },
            set: { if !$0 { presenter.errorMessage = nil } }
        )) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(presenter.errorMessage ?? "")
        }
        .task { await presenter.loadImages() }
    }
}

struct ReferenceListView_Previews: PreviewProvider {
    static var previews: some View {
        let interactor = ReferenceInteractor()
        let router = ReferenceRouter()
        let presenter = ReferencePresenter(interactor: interactor, router: router)
        ReferenceListView(presenter: presenter)
    }
}

