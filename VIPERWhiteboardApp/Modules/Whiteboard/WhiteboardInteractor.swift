//
//  WhiteboardInteractor.swift
//  VIPERWhiteboardApp
//
//  Created by next on 05/11/25.
import Foundation
import Foundation

protocol WhiteboardInteractorInput: AnyObject {
    func saveStrokes(_ strokes: [Stroke])
    func loadSavedStrokes() -> [Stroke]
    func clearAllStrokes()
}

final class WhiteboardInteractor: WhiteboardInteractorInput {
    private let storageKey = "com.company.viper.whiteboard.strokes"

    func saveStrokes(_ strokes: [Stroke]) {
        guard let data = try? JSONEncoder().encode(strokes) else { return }
        UserDefaults.standard.set(data, forKey: storageKey)
    }

    func loadSavedStrokes() -> [Stroke] {
        guard let data = UserDefaults.standard.data(forKey: storageKey),
              let strokes = try? JSONDecoder().decode([Stroke].self, from: data) else { return [] }
        return strokes
    }

    func clearAllStrokes() {
        UserDefaults.standard.removeObject(forKey: storageKey)
    }
}













