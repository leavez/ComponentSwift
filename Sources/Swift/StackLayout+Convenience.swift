//
//  StackLayout+Convenience.swift
//  Pods
//
//  Created by Gao on 20/05/2017.
//
//


public protocol StackLayoutChildType {
    var toChild: StackLayoutChild? {get}
}

extension Component: StackLayoutChildType {
    public var toChild: StackLayoutChild? {
        return self.stackLayoutChild
    }
}
extension StackLayoutChild: StackLayoutChildType {
    public var toChild: StackLayoutChild? {
        return self
    }
}




// MARK:- convenient initialier for stack layout component

extension StackLayoutComponent : StackComponentInitialierProtocol {
    public class func modifyStyle(_ v: StackLayoutStyle) { }
}

/// subclass of StackLayoutComponent, with preset layoutDirction
public class VerticalStackComponnet: StackLayoutComponent {
    public override class func modifyStyle(_ v: StackLayoutStyle) {
        v.direction = .vertical
    }
}
/// subclass of StackLayoutComponent, with preset layoutDirction
public class HorizontalStackComponnet: StackLayoutComponent {
    public override class func modifyStyle(_ v: StackLayoutStyle) {
        v.direction = .horizontal
    }
}

public protocol StackComponentInitialierProtocol: class {
    static func modifyStyle(_ v: StackLayoutStyle)
}
extension StackComponentInitialierProtocol where Self: StackLayoutComponent {

    public init(_ children:StackLayoutChildType?...) {
        self.init(style: nil, children: children)
    }
    public init(view: ViewConfiguration? = nil, style: StackLayoutStyle?, size:LayoutSize? = nil, children:StackLayoutChildType?...) {
        self.init(style: style, children: children)
    }
    public init(view: ViewConfiguration? = nil, style: StackLayoutStyle?, size:LayoutSize? = nil, children:[StackLayoutChildType?]) {

        let s = style ?? StackLayoutStyle()
        Self.modifyStyle(s)
        self.init(
            __view:view, size:size, style:s,
            children: children.flatMap{ $0?.toChild }
        )
    }
}



///
/// provide a way of typing:
///
/// ```
///    let style = StackLayoutStyle()
///                .direction(.vertical)
///                .spacing(5)
///
/// ```
extension StackLayoutStyle {

    public func direction(_ v: StackLayoutDirection) -> StackLayoutStyle {
        self.direction = v
        return self
    }
    public func spacing(_ v: CGFloat) -> StackLayoutStyle {
        self.spacing = v
        return self
    }
    public func justifyContent(_ v: StackLayoutJustifyContent) -> StackLayoutStyle {
        self.justifyContent = v
        return self
    }
    public func alignItems(_ v: StackLayoutAlignItems) -> StackLayoutStyle {
        self.alignItems = v
        return self
    }
}


extension StackLayoutChild {

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
    public func flexBasis(_ v: LayoutDimension?) -> StackLayoutChild {
        self.flexBasis = v
        return self
    }
    public func alignSelf(_ v: StackLayoutAlignSelf) -> StackLayoutChild {
        self.alignSelf = v
        return self
    }
}

/**

 ```
    TextComponent(
        /// ...
    ).stackLayoutChild
        .flexGrow(true)
        .flexShrink(true)

 ```
 */
extension Component {
    public var stackLayoutChild: StackLayoutChild {
        return StackLayoutChild().build {
            $0.component = self
        }
    }
}


