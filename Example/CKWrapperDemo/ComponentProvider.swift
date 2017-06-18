//
//  ComponentProvider.swift
//  CKWrapperDemo
//
//  Created by Gao on 16/05/2017.
//  Copyright © 2017 leave. All rights reserved.
//

import Foundation
import ComponentSwift

class Provider: NSObject, ComponentProviderProtocol {
    static func csComponent(forModel model: Any, context: Any?) -> Component? {

        guard let model = model as? Int else {
            return nil
        }

        return CompositeComponent(
            view:
            ViewConfiguration(
                attributes:
                A.backgroundColor(.white)
            ),
            component:
            SwiftComponent(model: model)
        )
    }
}
