//
//  ViewAttributes+Convenience.swift
//  Pods
//
//  Created by Gao on 27/04/2017.
//
//

import Foundation

public typealias ViewAttribute = CKWViewAttribute

public enum ViewAttributeEnum {

    case attribute(CKWViewAttribute, to: Any)
    case attributeWithValue(CKWViewAttributeValueType)

    // convenience
    case set(Selector, to:Any)
    case setLayer(Selector, to:Any)
    case tapGesture(Selector)

    internal func convert() -> (CKWViewAttributeBase, Any) {
        switch self {
        case .attribute(let a, to: let v):
            return (a, v)
        case .attributeWithValue(let o):
            return (o, 0)
        case .set(let sel, to: let v):
            return (CKWViewAttribute(sel), v)
        case .setLayer(let sel, to: let v):
            return (CKWViewAttribute(layerSetter:sel), v)
        case .tapGesture(let sel):
            return (CKWGestureAttribute(tapAction: sel), 0)
        }
    }
}

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

    public convenience init(enums: ViewAttributeEnum...) {
        self.init(enums);
    }
    public convenience init(_ attributes: [ViewAttributeEnum] ) {
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

    public convenience init(_ cls: AnyClass?, attributes:CKWViewAttributeMap? = nil) {
        self.init(viewClass: cls.map(CKWViewClass.init), viewAttributeMap: attributes)
    }

    public convenience init(_ cls: AnyClass?, _ attributes:[CKWViewAttributeBase: Any]) {
        let map = CKWViewAttributeMap(attributes)
        self.init(viewClass: cls.map(CKWViewClass.init), viewAttributeMap: map)
    }


    public convenience init(_ cls: AnyClass = UIView.self, attributeEnums: ViewAttributeEnum... ) {
        self.init(attributes: attributeEnums)
    }

    public convenience init(_ cls: AnyClass = UIView.self, attributes: [ViewAttributeEnum] ) {
        var dict: [CKWViewAttributeBase: Any] = [:]
        attributes.forEach {
            let keyValue = $0.convert()
            dict[keyValue.0] = keyValue.1
        }
        self.init(viewClass: CKWViewClass(cls), viewAttributeMap: CKWViewAttributeMap(dict))
    }

    public static func config(_ cls: AnyClass = UIView.self, attributes: ViewAttributeEnum...) -> CKWViewConfiguration {
        return CKWViewConfiguration(cls, attributes: attributes)
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

