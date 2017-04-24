//
//  CKWrapperConvenience.swift
//  CKWrapperDemo
//
//  Created by Gao on 23/04/2017.
//  Copyright © 2017 leave. All rights reserved.
//

import CKWrapper



extension CKWViewClass {
    convenience init(_ cls: AnyClass) {
        self.init(cls:cls)
    }
}

extension CKWViewAttribute {
    convenience init(_ setter: Selector) {
        self.init(setter: setter)
    }
}

extension CKWViewConfiguration {
    convenience init(_ cls: AnyClass, _ attributes:[CKWViewAttribute: Any]?) {
        self.init(viewClass: CKWViewClass(cls), viewAttributeMap: attributes)
    }
    convenience init(_ cls: AnyClass,
                     _ attributes:[Selector: Any]? = nil,
                     layerAttributes:[Selector: Any]? = nil,
                     gestures:[CKWGestureAttribute]? = nil
        ) {

        var converted: [CKWViewAttribute: Any]?
        if let attributes = attributes, attributes.count > 0 {
            var attrs: [CKWViewAttribute: Any] = [:]
            for (key,value) in attributes {
                attrs[CKWViewAttribute(setter: key)] = value
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

    static func config(_ cls: AnyClass,
                       _ attributes:[Selector: Any]? = nil,
                       layerAttributes:[Selector: Any]? = nil,
                       gestures:[CKWGestureAttribute]? = nil) -> CKWViewConfiguration {
        return CKWViewConfiguration(cls, attributes, layerAttributes: layerAttributes, gestures: gestures)
    }
}

extension CKWDimension {
    convenience init(_ value: CGFloat) {
        self.init(point: value)
    }
    static func p(_ value: CGFloat) -> CKWDimension {
        return CKWDimension(point: value)
    }
}

extension CKWSize {

    convenience init(_ size: CGSize) {
        self.init(cgSize: size)
    }
    convenience init(width: CGFloat? = nil,
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

    static func size(_ size: CGSize) -> CKWSize {
        return CKWSize(cgSize: size)
    }
    static func size(_ width: CGFloat, _ height: CGFloat) -> CKWSize {
        return CKWSize(cgSize: CGSize(width: width, height: height))
    }
    static func height(_ h: CGFloat) -> CKWSize {
        let s = self.init()
        s.height = .p(h)
        return s
    }
    static func width(_ w: CGFloat) -> CKWSize {
        let s = self.init()
        s.width = .p(w)
        return s
    }
}


protocol Builder {}
extension Builder where Self: AnyObject {

    func b(_ block: (Self) -> Void) -> Self {
        block(self)
        return self
    }
}
extension CKWCreatorBase : Builder {}
