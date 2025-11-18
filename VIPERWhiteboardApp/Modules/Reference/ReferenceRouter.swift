//
//  ReferenceRouter.swift
//  VIPERWhiteboardApp
//
//  Created by next on 12/11/25.
//

import SwiftUI

final class ReferenceRouter {
    @MainActor
    func createModule() -> some View {
        let interactor = ReferenceInteractor()
        let router = ReferenceRouter()
        let presenter = ReferencePresenter(interactor: interactor, router: router)
        return ReferenceListView(presenter: presenter)
    }

    func navigateBack() {}
}


