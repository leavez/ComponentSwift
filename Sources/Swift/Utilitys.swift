//
//  Utilitys.swift
//  Pods
//
//  Created by Gao on 04/05/2017.
//
//

import Foundation

extension ViewAttributeEnum {

    public static func backgroundColor(_ color: UIColor) -> ViewAttributeEnum {
        let value = CKWViewAttributeValueType()
        value.attribute = CKWViewAttribute(#selector(setter: UIView.backgroundColor))
        value.value = color
        return .attributeWithValue(value)
    }
    public static func roundCorner(raidus: CGFloat) -> ViewAttributeEnum {
        let value = CKWViewAttributeValueType()
        value.attribute = CKWViewAttribute(layerSetter: #selector(setter: CALayer.cornerRadius))
        value.value = raidus
        return .attributeWithValue(value)
    }
    public static func masksToBounds() -> ViewAttributeEnum {
        let value = CKWViewAttributeValueType()
        value.attribute = CKWViewAttribute(layerSetter: #selector(setter: CALayer.masksToBounds))
        value.value = true
        return .attributeWithValue(value)
    }
}
