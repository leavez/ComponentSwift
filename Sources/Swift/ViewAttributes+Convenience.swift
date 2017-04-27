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

public typealias ViewConfiguration = CKWViewConfiguration

extension CKWViewConfiguration {

    //TODO should be more convenient

    public convenience init(_ cls: AnyClass?, attributes:[CKWViewAttributeBase: Any]?) {
        self.init(viewClass: cls.map(CKWViewClass.init), viewAttributeMap: attributes)
    }
    public convenience init(_ cls: AnyClass?,
                     _ attributes:[Selector: Any]? = nil,
                     layerAttributes:[Selector: Any]? = nil,
                     attributesWithValue:[CKWViewAttributeValueType]? = nil
        ) {

        var converted: [CKWViewAttributeBase: Any]?
        if let attributes = attributes, attributes.count > 0 {
            var attrs: [CKWViewAttributeBase: Any] = [:]
            for (key,value) in attributes {
                attrs[CKWViewAttribute(key)] = value
            }
            converted = attrs
        }
        if let layerAttributes = layerAttributes, layerAttributes.count > 0 {
            converted = converted ?? [:]
            for (key,value) in layerAttributes {
                converted?[CKWViewAttribute(layerSetter:key)] = value
            }
        }
        if let attributeValues = attributesWithValue, attributeValues.count > 0 {
            converted = converted ?? [:]
            for g in attributeValues {
                converted?[g] = 0 // we don't use the value
            }
        }
        self.init(viewClass: cls.map(CKWViewClass.init), viewAttributeMap: converted)
    }

    public convenience init(_ cls: AnyClass = UIView.self,
                            attributes: ViewAttributeEnum...
        ) {
        let converted: [CKWViewAttributeBase: Any] = attributes.reduce([:], {
            var dict = $0
            let keyValue = $1.convert()
            dict[keyValue.0] = keyValue.1
            return dict
        })
        self.init(viewClass: CKWViewClass(cls), viewAttributeMap: converted)
    }

    public static func config(_ cls: AnyClass,
                       _ attributes:[Selector: Any]? = nil,
                       layerAttributes:[Selector: Any]? = nil,
                       attributeValues:[CKWGestureAttribute]? = nil) -> CKWViewConfiguration {
        return CKWViewConfiguration(cls, attributes, layerAttributes: layerAttributes, attributesWithValue: attributeValues)
    }
}


extension CKWDimension {

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
    public convenience init(width: CGFloat? = nil,
                     height:CGFloat? = nil,
                     minWidth: CGFloat? = nil,
                     maxWidth: CGFloat? = nil,
                     minHeight: CGFloat? = nil,
                     maxHeight: CGFloat? = nil) {
        self.init()
        self.width = width.map{ CKWDimension(point: $0) }
        self.height = height.map{ CKWDimension(point: $0) }
        self.minWidth = minWidth.map{ CKWDimension(point: $0) }
        self.maxWidth = maxWidth.map{ CKWDimension(point: $0) }
        self.minHeight = minHeight.map{ CKWDimension(point: $0) }
        self.maxHeight = maxHeight.map{ CKWDimension(point: $0) }
    }

    public convenience init(size: CGSize,
                     minWidth: CGFloat? = nil,
                     maxWidth: CGFloat? = nil,
                     minHeight: CGFloat? = nil,
                     maxHeight: CGFloat? = nil) {
        self.init()
        self.width = .p(size.width)
        self.height = .p(size.height)
        self.minWidth = minWidth.map{ CKWDimension(point: $0) }
        self.maxWidth = maxWidth.map{ CKWDimension(point: $0) }
        self.minHeight = minHeight.map{ CKWDimension(point: $0) }
        self.maxHeight = maxHeight.map{ CKWDimension(point: $0) }
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

