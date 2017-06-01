//
//  ComponentAdvanced+Convenience.swift
//  Pods
//
//  Created by Gao on 09/05/2017.
//
//

import Foundation


public protocol ComponentStateProtocol: class {
    associatedtype StateType
}

public protocol ComponentInitialStateProtocol: ComponentStateProtocol {
    static func initialState() -> StateType
}

public extension ComponentStateProtocol where Self: CompositeComponent {
    // Because the state value is constraint by ComponentStateProtocol,
    // which is controlled by us, the force unwrap will always succeed

    public func updateState(_ updateBlock: @escaping (StateType)->StateType, asynchronously: Bool) {
        self.__updateState({
            updateBlock($0 as! StateType)
        }, asynchronously: asynchronously)
    }
}


open class CompositeComponent: __CompositeComponent {

    public override init?(component: Component?) {
        super.init(component: component)
    }

    public override init?(view: ViewConfiguration?, component: Component?) {
        super.init(view: view, component: component)
    }

    public override init?(scope: Scope?, component: Component?) {
        super.init(scope: scope, component: component)
    }

    public init?<T>(scope: StateScope<T>?, componentConstructor: (T) -> Component?) {
        super.init(__scope:scope, componentConstructor: {
            componentConstructor($0 as! T)
        })
    }
}



public class StateScope<ValueType>: Scope {

    public init<ClassType>(with cls: ClassType.Type, identifier: String? = nil)
        where ClassType: CompositeComponent,
        ClassType: ComponentInitialStateProtocol,
        ClassType.StateType == ValueType
    {
        super.init(__with: cls, identifier: identifier) { () -> ClassType.StateType in
            cls.initialState()
        }
    }

    public init<ClassType>(with cls: ClassType.Type,
                identifier: String?,
                initialStateCreator: @escaping () -> ValueType )
        where ClassType: CompositeComponent,
        ClassType: ComponentStateProtocol,
        ClassType.StateType == ValueType
    {
        super.init(__with: cls, identifier: identifier, initialStateCreator: initialStateCreator)
    }
}
