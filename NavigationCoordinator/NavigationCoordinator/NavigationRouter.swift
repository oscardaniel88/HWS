//
//  NavigationRouter.swift
//  NavigationCoordinator
//
//  Created by Daniel Camarena on 11/24/23.
//

import SwiftUI

public enum NavigationTranisitionStyle {
    case push
    case presentModally
    case presentFullscreen
}

public protocol NavigationRouter {
    associatedtype V: View
    
    var transition: NavigationTranisitionStyle { get }
    
    @ViewBuilder
    func view() -> V
}
