//
//  MapRouter.swift
//  NavigationCoordinator
//
//  Created by Daniel Camarena on 11/24/23.
//

import SwiftUI

public enum MapRouter: NavigationRouter {
    case map
    case city(named: String)
    case state(named: String)
    
    public var transition: NavigationTranisitionStyle {
        switch self {
        case .map:
            return .push
        case .city:
            return .presentModally
        case .state:
            return .presentModally
        }
    }
    
    @ViewBuilder
    public func view() -> some View {
        switch self {
        case .map:
            MapView()
        case .city(named: let name):
            CityView(name: name)
        case .state(named: let name):
            StateView(name: name)
        }
    }
}
