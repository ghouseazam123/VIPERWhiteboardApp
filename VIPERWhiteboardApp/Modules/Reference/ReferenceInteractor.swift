//
//  ReferenceInteractor.swift
//  VIPERWhiteboardApp
//
//  Created by next on 12/11/25.
//
import Foundation

protocol ReferenceInteractorInput {
    func fetchImages() async throws -> [ReferenceImage]
}


final class ReferenceInteractor: ReferenceInteractorInput {
    func fetchImages() async throws -> [ReferenceImage] {
        guard let url = URL(string: "https://picsum.photos/v2/list")
        else { throw NetworkError.invalidURL }

        return try await NetworkManager.shared.fetchData(from: url)
    }
}





