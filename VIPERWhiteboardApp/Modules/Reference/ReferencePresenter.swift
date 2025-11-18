//
//  ReferencePresenter.swift
//  VIPERWhiteboardApp
//
//  Created by next on 12/11/25.
//


import Foundation

@MainActor
final class ReferencePresenter: ObservableObject {
    @Published var images: [ReferenceImage] = []
    @Published var errorMessage: String?

    private let interactor: ReferenceInteractorInput
    private let router: ReferenceRouter

    init(interactor: ReferenceInteractorInput, router: ReferenceRouter) {
        self.interactor = interactor
        self.router = router
    }

    func loadImages() async {
        do {
            let fetched = try await interactor.fetchImages()
            images = Array(fetched.dropFirst(9))
        } catch let error as NetworkError {
            switch error {
            case .invalidURL:
                errorMessage = "Invalid URL. Please contact support."
            case .invalidResponse:
                errorMessage = "Invalid response from server."
            case .httpError(let code):
                errorMessage = "Server returned error code: \(code)"
            case .decodingError(let err):
                errorMessage = "Failed to decode data: \(err.localizedDescription)"
            }
        } catch {
            errorMessage = "An unknown error occurred: \(error.localizedDescription)"
        }
    }

    func goBack() {
        router.navigateBack()
    }
}





