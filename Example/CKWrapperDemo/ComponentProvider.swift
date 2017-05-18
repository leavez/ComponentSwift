//
//  ComponentProvider.swift
//  CKWrapperDemo
//
//  Created by Gao on 16/05/2017.
//  Copyright © 2017 leave. All rights reserved.
//

import Foundation
import ComponentSwift

class Provider: NSObject, ComponentProvider {

    static func ckwComponent(forModel model: Any, context: Any?) -> Component? {

        return CompositeComponent(
            view:
            CKWViewConfiguration(
                attributes:
                A.backgroundColor(.white)
            ),
            component:
            SwiftComponent(model: 1)
        )
    }
}
