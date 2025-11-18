//
//  MainApp.swift
//  VIPERWhiteboardApp
//
//  Created by next on 05/11/25.

import SwiftUI

@main
struct VIPERWhiteboardApp: App {
    var body: some Scene {
        WindowGroup {
            let interactor = WhiteboardInteractor()
            let router = WhiteboardRouter()
            let presenter = WhiteboardPresenter(interactor: interactor, router: router)
            WhiteboardView(presenter: presenter)
        }
    }
}





