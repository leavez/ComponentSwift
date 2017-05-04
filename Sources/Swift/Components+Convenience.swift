//
//  CenterLayoutComponent+Convenience.swift
//  Pods
//
//  Created by Gao on 28/04/2017.
//
//

import UIKit

extension InsetComponent {
}

extension CenterLayoutComponent {

    public convenience init?(centering: CKWCenterLayoutComponentCenteringOptions = .XY,
                             sizing: CKWCenterLayoutComponentSizingOptions = .minimumXY,
                             child: Component?, size: CKWSize? = nil) {
      self.init(__centeringOptions: centering, sizingOptions: sizing, child: child, size: size)
    }
}

extension TextComponent {

    public convenience init(_ textAttributes: CKWTextAttributes,
                            viewAttributes: CKWViewAttributeMap? = nil,
                            options: CKWTextComponentOptions? = nil,
                            size: CKWSize? = nil) {
        self.init(__textAttributes: textAttributes, viewAttributes: viewAttributes, options: options, size: size)
    }
}

extension CKWTextAttributes {

    public convenience init(_ attributedString: NSAttributedString?) {
        self.init()
        self.attributedString = attributedString
    }
    public convenience init(_ string: String?, attrs: [String : Any], numberOfLines:Int = 0) {
        self.init()
        self.attributedString = string.map{ NSAttributedString(string: $0, attributes: attrs) }
        self.maximumNumberOfLines = numberOfLines
    }
    public convenience init(_ string: String?, font: UIFont = UIFont.systemFont(ofSize: 14)) {
        self.init()
        self.attributedString = string.map{ NSAttributedString(string: $0, attributes: [NSFontAttributeName: font]) }
    }
}



extension StackLayoutComponent {

    public convenience init(view: CKWViewConfiguration? = nil,
                            size: CKWSize? = nil,
                            style: CKWStackLayoutStyle? = nil,
                            children: [CKWStackLayoutChild?] )
    {
        self.init(__view:view, size:size, style:style, children:children.flatMap{ $0 })
    }
    public convenience init(view: CKWViewConfiguration? = nil,
                            size: CKWSize? = nil,
                            style: CKWStackLayoutStyle? = nil,
                            childrenComponents: [Component?] )
    {
        self.init(__view:view, size:size, style:style, children:childrenComponents.flatMap{ CKWStackLayoutChild($0) })
    }
}

public typealias StackLayoutChild = CKWStackLayoutChild

extension CKWStackLayoutChild {

    public convenience init?(_ component: Component?,
                            spacingAfter: CGFloat = 0,
                            spacingBefore: CGFloat = 0,
                            flexGrow: Bool = false,
                            flexShrink: Bool = false,
                            flexBasis: CKWDimension? = nil,
                            alignSelf: CKWStackLayoutAlignSelf = .auto) {
        guard let component = component else {
            return nil
        }
        self.init()
        self.component = component
        self.spacingAfter = spacingAfter
        self.spacingBefore = spacingBefore
        self.flexGrow = flexGrow
        self.flexShrink = flexShrink
        self.flexBasis = flexBasis
        self.alignSelf = alignSelf
    }
}




