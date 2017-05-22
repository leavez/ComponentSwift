//
//  ViewAttributes+Convenience.swift
//  Pods
//
//  Created by Gao on 27/04/2017.
//
//

import Foundation


extension CKWViewAttributeBase {

    public static func set(_ setter: Selector) -> CKWViewAttribute {
        return CKWViewAttribute(setter)
    }
    public static func setLayer(_ setter: Selector) -> CKWViewAttribute {
        return CKWViewAttribute(layerSetter: setter)
    }
}

extension CKWViewAttribute {
    public convenience init(identifier: String,
                            applicator: @escaping (_ view: Any, _ value: Any) -> Void,
                            unapplicator:((_ view: Any, _ value: Any) -> Void)?                     = nil,
                            updater:     ((_ view: Any, _ oldValue: Any, _ newValue: Any) -> Void)? = nil) {

        self.init(identifierString:identifier, applicator:applicator, unapplicator:unapplicator, updater:updater)
    }

}

extension CKWViewAttributeMap {

    public convenience init(_ attributes: Attribute...) {
        self.init(attributes:attributes);
    }
    public convenience init(attributes: [Attribute] ) {
        var dict: [CKWViewAttributeBase: Any] = [:]
        attributes.forEach {
            let keyValue = $0.convert()
            dict[keyValue.0] = keyValue.1
        }
        self.init(dict)
    }

//    public init(dictionaryLiteral elements: (Self.Key, Self.Value)...)

}


extension CKWViewConfiguration {

    public convenience init(_ cls: AnyClass?, attributeMap: CKWViewAttributeMap? = nil) {
        self.init(viewClass: cls.map(CKWViewClass.init), viewAttributeMap: attributeMap)
    }

    public convenience init(_ cls: AnyClass?, attributeDictionay: [CKWViewAttributeBase: Any]) {
        let map = CKWViewAttributeMap(attributeDictionay)
        self.init(viewClass: cls.map(CKWViewClass.init), viewAttributeMap: map)
    }

    public convenience init(_ cls: AnyClass = UIView.self, attributes: Attribute... ) {
        self.init(cls, attributes: attributes)
    }

    public convenience init(_ cls: AnyClass = UIView.self, attributes: [Attribute] ) {
        var dict: [CKWViewAttributeBase: Any] = [:]
        attributes.forEach {
            let keyValue = $0.convert()
            dict[keyValue.0] = keyValue.1
        }
        self.init(viewClass: CKWViewClass(cls), viewAttributeMap: CKWViewAttributeMap(dict))
    }
}


extension CKWDimension: ExpressibleByFloatLiteral {

    public convenience init(_ value: CGFloat) {
        self.init(point: value)
    }
    public static func p(_ value: CGFloat) -> CKWDimension {
        return CKWDimension(point: value)
    }
    public static func percent(_ value: CGFloat) -> CKWDimension {
        return CKWDimension(percent: value)
    }
}



extension CKWSize {

    public convenience init(size: CGSize) {
        self.init(cgSize: size)
    }
    public convenience init(width: CKWDimension? = nil,
                     height:CKWDimension? = nil,
                     minWidth: CKWDimension? = nil,
                     maxWidth: CKWDimension? = nil,
                     minHeight: CKWDimension? = nil,
                     maxHeight: CKWDimension? = nil) {
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
                     minWidth: CKWDimension? = nil,
                     maxWidth: CKWDimension? = nil,
                     minHeight: CKWDimension? = nil,
                     maxHeight: CKWDimension? = nil) {
        self.init()
        self.width = .p(size.width)
        self.height = .p(size.height)
        self.minWidth = minWidth
        self.maxWidth = maxWidth
        self.minHeight = minHeight
        self.maxHeight = maxHeight
    }

    public static func size(_ size: CGSize) -> CKWSize {
        return CKWSize(cgSize: size)
    }
    public static func size(_ width: CGFloat, _ height: CGFloat) -> CKWSize {
        return CKWSize(cgSize: CGSize(width: width, height: height))
    }
    public static func height(_ h: CGFloat) -> CKWSize {
        let s = self.init()
        s.height = .p(h)
        return s
    }
    public static func width(_ w: CGFloat) -> CKWSize {
        let s = self.init()
        s.width = .p(w)
        return s
    }
}

