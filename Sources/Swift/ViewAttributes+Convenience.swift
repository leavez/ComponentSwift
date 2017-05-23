//
//  ViewAttributes+Convenience.swift
//  Pods
//
//  Created by Gao on 27/04/2017.
//
//

import Foundation

extension ViewAttributeBase {

    public static func set(_ setter: Selector) -> ViewAttribute {
        return ViewAttribute(setter)
    }
    public static func setLayer(_ setter: Selector) -> ViewAttribute {
        return ViewAttribute(layerSetter: setter)
    }
}

extension ViewAttribute {
    public convenience init(identifier: String,
                            applicator: @escaping (_ view: Any, _ value: Any) -> Void,
                            unapplicator:((_ view: Any, _ value: Any) -> Void)?                     = nil,
                            updater:     ((_ view: Any, _ oldValue: Any, _ newValue: Any) -> Void)? = nil) {

        self.init(identifierString:identifier, applicator:applicator, unapplicator:unapplicator, updater:updater)
    }

}

extension ViewAttributeMap {

    public convenience init(_ attributes: Attribute...) {
        self.init(attributes:attributes);
    }
    public convenience init(attributes: [Attribute] ) {
        var dict: [ViewAttributeBase: Any] = [:]
        attributes.forEach {
            let keyValue = $0.convert()
            dict[keyValue.0] = keyValue.1
        }
        self.init(dict)
    }
}


extension ViewConfiguration {

    public convenience init(_ cls: AnyClass?, attributeMap: ViewAttributeMap? = nil) {
        self.init(viewClass: cls.map(ViewClass.init), viewAttributeMap: attributeMap)
    }

    public convenience init(_ cls: AnyClass?, attributeDictionay: [ViewAttributeBase: Any]) {
        let map = ViewAttributeMap(attributeDictionay)
        self.init(viewClass: cls.map(ViewClass.init), viewAttributeMap: map)
    }

    public convenience init(_ cls: AnyClass = UIView.self, attributes: Attribute... ) {
        self.init(cls, attributes: attributes)
    }

    public convenience init(_ cls: AnyClass = UIView.self, attributes: [Attribute] ) {
        var dict: [ViewAttributeBase: Any] = [:]
        attributes.forEach {
            let keyValue = $0.convert()
            dict[keyValue.0] = keyValue.1
        }
        self.init(viewClass: ViewClass(cls), viewAttributeMap: ViewAttributeMap(dict))
    }
}


extension LayoutDimension: ExpressibleByFloatLiteral {

    public convenience init(_ value: CGFloat) {
        self.init(point: value)
    }
    public static func p(_ value: CGFloat) -> LayoutDimension {
        return LayoutDimension(point: value)
    }
    public static func percent(_ value: CGFloat) -> LayoutDimension {
        return LayoutDimension(percent: value)
    }
}



extension LayoutSize {

    public convenience init(size: CGSize) {
        self.init(cgSize: size)
    }
    public convenience init(width: LayoutDimension? = nil,
                     height:LayoutDimension? = nil,
                     minWidth: LayoutDimension? = nil,
                     maxWidth: LayoutDimension? = nil,
                     minHeight: LayoutDimension? = nil,
                     maxHeight: LayoutDimension? = nil) {
        self.init()
        self.width = width
        self.height = height
        self.minWidth = minWidth 
        self.maxWidth = maxWidth 
        self.minHeight = minHeight 
        self.maxHeight = maxHeight 
    }
    public convenience init(width: CGFloat? = nil,
                            height:CGFloat? = nil,
                            minWidth: CGFloat? = nil,
                            maxWidth: CGFloat? = nil,
                            minHeight: CGFloat? = nil,
                            maxHeight: CGFloat? = nil) {
        self.init()
        if let width = width {
            self.width = .p(width)
        }
        if let height = height {
            self.height = .p(height)
        }
        if let minWidth = minWidth {
            self.minWidth = .p(minWidth)
        }
        if let maxWidth = maxWidth {
            self.maxWidth = .p(maxWidth)
        }
        if let minHeight = minHeight {
            self.minHeight = .p(minHeight)
        }
        if let maxHeight = maxHeight {
            self.maxHeight = .p(maxHeight)
        }
    }

    public convenience init(size: CGSize,
                     minWidth: LayoutDimension? = nil,
                     maxWidth: LayoutDimension? = nil,
                     minHeight: LayoutDimension? = nil,
                     maxHeight: LayoutDimension? = nil) {
        self.init()
        self.width = .p(size.width)
        self.height = .p(size.height)
        self.minWidth = minWidth
        self.maxWidth = maxWidth 
        self.minHeight = minHeight
        self.maxHeight = maxHeight
    }

    public static func size(_ size: CGSize) -> LayoutSize {
        return LayoutSize(cgSize: size)
    }
    public static func size(_ width: CGFloat, _ height: CGFloat) -> LayoutSize {
        return LayoutSize(cgSize: CGSize(width: width, height: height))
    }
    public static func height(_ h: CGFloat) -> LayoutSize {
        let s = self.init()
        s.height = .p(h)
        return s
    }
    public static func width(_ w: CGFloat) -> LayoutSize {
        let s = self.init()
        s.width = .p(w)
        return s
    }
}

