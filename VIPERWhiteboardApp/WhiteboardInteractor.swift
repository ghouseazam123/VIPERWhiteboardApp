//
//  WhiteboardInteractor.swift
//  VIPERWhiteboardApp
//
//  Created by next on 05/11/25.
//

// WhiteboardInteractor.swift
// WhiteboardInteractor.swift

import Foundation

protocol WhiteboardInteractorInput: AnyObject {
    func saveStrokes(_ strokes: [Stroke])
    func loadSavedStrokes() -> [Stroke]
    func clearAllStrokes()
}

final class WhiteboardInteractor: WhiteboardInteractorInput {
    private let storageKey = "com.company.viper.whiteboard.strokes"

    func saveStrokes(_ strokes: [Stroke]) {
        do {
            let data = try JSONEncoder().encode(strokes)
            UserDefaults.standard.set(data, forKey: storageKey)
        } catch {
            print("❌ Failed to save strokes: \(error)")
        }
    }

    func loadSavedStrokes() -> [Stroke] {
        guard let data = UserDefaults.standard.data(forKey: storageKey) else { return [] }
        do {
            return try JSONDecoder().decode([Stroke].self, from: data)
        } catch {
            print("❌ Failed to decode strokes: \(error)")
            return []
        }
    }

    func clearAllStrokes() {
        UserDefaults.standard.removeObject(forKey: storageKey)
    }
}







