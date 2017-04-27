//
//  CenterLayoutComponent+Convenience.swift
//  Pods
//
//  Created by Gao on 28/04/2017.
//
//

import Foundation

extension CenterLayoutComponent {

    public convenience init?(centering: CKWCenterLayoutComponentCenteringOptions = .XY,
                             sizing: CKWCenterLayoutComponentSizingOptions = .minimumXY,
                             child: Component?, size: CKWSize? = nil) {
        self.init(centeringOptions: centering, sizingOptions: sizing, childComponent: child, size: size)
    }
}
