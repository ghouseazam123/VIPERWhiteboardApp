//
//  NetworkManage.swift
//  VIPERWhiteboardApp
//
//  Created by next on 10/11/25.
//

import Foundation
import Foundation

final class NetworkManager {
    static let shared = NetworkManager()

    private init() {} // Prevent external initialization

    /// Fetch image data from a URL
    func fetchImage(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                completion(.success(data))
            } else {
                let unknownError = NSError(domain: "NetworkManager",
                                           code: -1,
                                           userInfo: [NSLocalizedDescriptionKey: "Unknown error occurred"])
                completion(.failure(unknownError))
            }
        }.resume()
    }
}
