//
//  general.swift
//  Pods
//
//  Created by Gao on 27/04/2017.
//
//

import Foundation


public protocol ObjectBuilder {}
public protocol Builder {}


extension ObjectBuilder where Self: AnyObject {

    public func build(_ block: (Self) -> Void) -> Self {
        block(self)
        return self
    }
}

extension Builder where Self: Any {

    public func build(_ block: (inout Self) -> Void) -> Self {
        var copy = self
        block(&copy)
        return copy
    }
}

extension OptionBase : Builder {}
