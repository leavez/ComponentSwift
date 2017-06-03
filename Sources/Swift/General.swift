//
//  general.swift
//  Pods
//
//  Created by Gao on 27/04/2017.
//
//

import Foundation


public protocol Builder {}

extension Builder {

    public func build(_ block: (inout Self) -> Void) -> Self {
        var copy = self
        block(&copy)
        return copy
    }
}


extension OptionBase : Builder {}
