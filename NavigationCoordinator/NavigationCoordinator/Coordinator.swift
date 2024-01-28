//
//  Coordinator.swift
//  NavigationCoordinator
//
//  Created by Daniel Camarena on 11/24/23.
//

import SwiftUI

open class Coordinator<Router: NavigationRouter>: ObservableObject {
    
    public let navigationController: UINavigationController
    public let startingRoute: Router?
    public var currentRoute: Router?
    
    public init(navigationController: UINavigationController = .init(), startingRoute: Router? = nil) {
        self.navigationController = navigationController
        self.startingRoute = startingRoute
        self.currentRoute = startingRoute
    }
    
    public func start() {
        guard let route = startingRoute else { return }
        show(route)
    }
    
    public func show(_ route: Router, animated: Bool = true) {
        currentRoute = route
        let view = route.view()
        let viewWithCoordinator = view.environmentObject(self)
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        switch route.transition {
        case .push:
            navigationController.pushViewController(viewController, animated: animated)
        case .presentModally:
            viewController.modalPresentationStyle = .formSheet
            navigationController.present(viewController, animated: animated)
        case.presentFullscreen:
            viewController.modalPresentationStyle = .fullScreen
            navigationController.present(viewController, animated: animated)
        }
    }
    
    private func pop(animated: Bool = true) {
        navigationController.popViewController(animated: animated)
    }
    
    private func popToRoot(animated: Bool = true) {
        navigationController.popToRootViewController(animated: animated)
    }
    
    private func dismiss(animated: Bool = true) {
        navigationController.dismiss(animated: animated)
    }
    
    public func smartDisiss(animated: Bool = true) {
        guard let route = currentRoute else { return }
        switch route.transition {
        case .push :
            self.pop()
            return
        case .presentFullscreen :
            self.dismiss()
            return
        case .presentModally :
            self.dismiss()
            return
        }
    }
}


