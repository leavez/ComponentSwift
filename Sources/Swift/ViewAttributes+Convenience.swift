//
//  ViewAttributes+Convenience.swift
//  Pods
//
//  Created by Gao on 27/04/2017.
//
//

import Foundation

public typealias ViewAttribute = CKWViewAttribute
extension CKWViewAttribute {
    public convenience init(identifier: String,
                            applicator: @escaping (_ view: Any, _ value: Any) -> Void,
                            unapplicator:((_ view: Any, _ value: Any) -> Void)?                     = nil,
                            updater:     ((_ view: Any, _ oldValue: Any, _ newValue: Any) -> Void)? = nil) {

        self.init(identifierString:identifier, applicator:applicator, unapplicator:unapplicator, updater:updater)
    }

    public static func set(_ setter: Selector) -> CKWViewAttribute {
        return self.init(setter)
    }
    public static func setLayer(_ setter: Selector) -> CKWViewAttribute {
        return self.init(layerSetter: setter)
    }
}

public typealias ViewConfiguration = CKWViewConfiguration

extension CKWViewConfiguration {

    //TODO should be more convenient

    public convenience init(_ cls: AnyClass, _ attributes:[CKWViewAttribute: Any]?) {
        self.init(viewClass: CKWViewClass(cls), viewAttributeMap: attributes)
    }
    public convenience init(_ cls: AnyClass = UIView.self,
                     _ attributes:[Selector: Any]? = nil,
                     layerAttributes:[Selector: Any]? = nil,
                     gestures:[CKWGestureAttribute]? = nil
        ) {

        var converted: [CKWViewAttribute: Any]?
        if let attributes = attributes, attributes.count > 0 {
            var attrs: [CKWViewAttribute: Any] = [:]
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
        if let gestures = gestures, gestures.count > 0 {
            converted = converted ?? [:]
            for g in gestures {
                converted?[g] = 0 // we don't use the value
            }
        }
        self.init(viewClass: CKWViewClass(cls), viewAttributeMap: converted)
    }

    public convenience init(_ cls: AnyClass = UIView.self,
                            attributes: (CKWViewAttribute, to: Any)...
        ) {
        let converted: [CKWViewAttribute: Any] = attributes.reduce([:], {
            var dict = $0
            dict[$1.0] = $1.1
            return dict
        })
        self.init(viewClass: CKWViewClass(cls), viewAttributeMap: converted)
    }

    public static func config(_ cls: AnyClass,
                       _ attributes:[Selector: Any]? = nil,
                       layerAttributes:[Selector: Any]? = nil,
                       gestures:[CKWGestureAttribute]? = nil) -> CKWViewConfiguration {
        return CKWViewConfiguration(cls, attributes, layerAttributes: layerAttributes, gestures: gestures)
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

