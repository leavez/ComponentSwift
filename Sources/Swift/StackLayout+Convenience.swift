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
        return StackLayoutChild().build({
            $0.component = self
        })
    }
}
extension StackLayoutChild: StackLayoutChildType {
    public var toChild: StackLayoutChild? {
        return self
    }
}


public class VerticalStackComponnet: StackLayoutComponent {

    public convenience init(_ children:StackLayoutChildType?...) {
        self.init(style: nil, children: children)
    }
    public convenience init(style: StackLayoutStyle?, children:StackLayoutChildType?...) {
        self.init(style: style, children: children)
    }
    public init(style: StackLayoutStyle?, children:[StackLayoutChildType?]) {

        style?.direction = .vertical
        super.init(
            __view:nil, size:nil, style:style,
            children: children.flatMap{ $0?.toChild }
        )
    }
}
public class HorizontalStackComponnet: StackLayoutComponent {

    public convenience init(_ children:StackLayoutChildType?...) {
        self.init(style: nil, children: children)
    }
    public convenience init(style: StackLayoutStyle?, children:StackLayoutChildType?...) {
        self.init(style: style, children: children)
    }
    public init(style: StackLayoutStyle?, children:[StackLayoutChildType?]) {

        style?.direction = .horizontal
        super.init(
            __view:nil, size:nil, style:style,
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
    public func flexGrow(_ v: CGFloat) -> StackLayoutChild {
        self.flexGrow = v
        return self
    }
    public func flexShrink(_ v: CGFloat) -> StackLayoutChild {
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
        let c = StackLayoutChild()
        c.component = self
        return c
    }
}


