//
//  general.swift
//  Pods
//
//  Created by Gao on 27/04/2017.
//
//

import Foundation


public protocol Builder {}

extension Builder where Self: AnyObject {

    public func build(_ block: (Self) -> Void) -> Self {
        block(self)
        return self
    }
}

extension CreatorBase : Builder {}
