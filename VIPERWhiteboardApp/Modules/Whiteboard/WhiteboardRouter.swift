//
//  WhiteboardRouter.swift
//  VIPERWhiteboardApp
//
//  Created by next on 05/11/25.
// File: WhiteboardRouter.swift
import SwiftUI

final class WhiteboardRouter {
    @MainActor
    func navigateToReferenceView() -> some View {
        let interactor = ReferenceInteractor()
        let router = ReferenceRouter()
        let presenter = ReferencePresenter(interactor: interactor, router: router)
        return ReferenceListView(presenter: presenter)
    }
}











