//
//  StackLayout+Convenience.swift
//  Pods
//
//  Created by Gao on 20/05/2017.
//
//
import Foundation


public protocol StackLayoutChildType {
}
extension Component: StackLayoutChildType {
}
extension StackLayoutChild: StackLayoutChildType {
}

extension StackLayoutChildType  {

    func convertToStackChild() -> StackLayoutChild? {
        switch self {
        case let child as StackLayoutChild:
            return child
        case let component as Component:
            let child = StackLayoutChild()
            child.component = component
            return child
        case _:
            return nil
        }
    }
}



public class VerticalStackComponnet: StackLayoutComponent {

    public init(_ children:StackLayoutChildType?...) {

        super.init(
            __view:nil, size:nil,
            style:CKWStackLayoutStyle().build({
                $0.direction = .vertical
            }),
            children: children.flatMap{ $0?.convertToStackChild() }
        )
    }
}
public class HorizontalStackComponnet: StackLayoutComponent {

    public init(_ children:StackLayoutChildType?...) {

        super.init(
            __view:nil, size:nil,
            style:CKWStackLayoutStyle().build({
                $0.direction = .horizontal
            }),
            children: children.flatMap{ $0?.convertToStackChild() }
        )
    }
}

extension Component {
    public var stackLayoutChild: StackLayoutChild {
        let c = StackLayoutChild()
        c.component = self
        return c
    }
}


struct Child {

    public func spacingBefore(_ v: CGFloat) -> StackLayoutChild {
        self.spacingBefore = v
        return self
    }
    public func spacingAfter(_ v: CGFloat) -> StackLayoutChild {
        self.spacingAfter = v
        return self
    }
    public func flexGrow(_ v: Bool) -> StackLayoutChild {
        self.flexGrow = v
        return self
    }
    public func flexShrink(_ v: Bool) -> StackLayoutChild {
        self.flexShrink = v
        return self
    }
    public func flexBasis(_ v: CKWDimension?) -> StackLayoutChild {
        self.flexBasis = v
        return self
    }
    public func alignSelf(_ v: CKWStackLayoutAlignSelf) -> StackLayoutChild {
        self.alignSelf = v
        return self
    }
}




