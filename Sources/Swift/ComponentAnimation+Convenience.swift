//
//  ComponentAnimation+Convenience.swift
//  Pods
//
//  Created by Gao on 5/16/17.
//
//

import Foundation

extension ComponentAnimation {

    @nonobjc
    public convenience init(component: Component, animation: CAAnimation?, layerPath: String? = nil) {
        self.init(__component:component, animation: animation, layerPath: layerPath)
    }

    /// return nil when component is nil
    @nonobjc
    public convenience init?(component: Component?, animation: CAAnimation?, layerPath: String? = nil) {
        guard let component = component else {
            return nil
        }
        self.init(__component:component, animation: animation, layerPath: layerPath)
    }
}
