//
//  Utilitys.swift
//  Pods
//
//  Created by Gao on 04/05/2017.
//
//

import Foundation

public enum Attribute {

    case attribute(CKWViewAttribute, to: Any?)
    case attributeWithValue(CKWViewAttributeValueType)

    // convenience
    case set(Selector, to:Any?)
    case setLayer(Selector, to:Any?)

    internal func convert() -> (CKWViewAttributeBase, Any?) {
        switch self {
        case .attribute(let a, to: let v):
            return (a, v)
        case .attributeWithValue(let o):
            return (o, 0)
        case .set(let sel, to: let v):
            return (CKWViewAttribute(sel), v)
        case .setLayer(let sel, to: let v):
            return (CKWViewAttribute(layerSetter:sel), v)
        }
    }
}

/// Code completion doesn't work very well for static method, so we may explict
/// write the type. We will use this type frequently, so give it a short name.
public typealias A = Attribute


// MARK:- Selector doesn't work well with code completion in swift, so we preset
// many methods.

// convenient
extension Attribute {

    public static func tapGesture(_ selector:Selector) -> Attribute {
        return .attributeWithValue(CKWGestureAttribute(tapAction: selector))
    }
    public static func roundCorner(raidus: CGFloat) -> Attribute {
        return .setLayer(#selector(setter: CALayer.cornerRadius), to: raidus)
    }
}

// UIView
extension Attribute {

    public static func backgroundColor(_ color: UIColor?) -> Attribute {
        return .set(#selector(setter: UIView.backgroundColor), to: color)
    }
    public static func tag(_ v: Int) -> Attribute {
        return .set(#selector(setter: UIView.tag), to: v)
    }
    public static func clipsToBounds(_ v: Bool) -> Attribute {
        return .set(#selector(setter: UIView.clipsToBounds), to: v)
    }
    public static func alpha(_ v: CGFloat) -> Attribute {
        return .set(#selector(setter: UIView.alpha), to: v)
    }
    public static func isOpaque(_ v: Bool) -> Attribute {
        return .set(#selector(setter: UIView.isOpaque), to: v)
    }
    public static func isHidden(_ v: Bool) -> Attribute {
        return .set(#selector(setter: UIView.isHidden), to: v)
    }
    public static func contentMode(_ v: UIViewContentMode) -> Attribute {
        return .set(#selector(setter: UIView.contentMode), to: v)
    }
    public static func tintColor(_ v: UIColor?) -> Attribute {
        return .set(#selector(setter: UIView.tintColor), to: v)
    }
    public static func tintAdjustmentMode(_ v: UIViewTintAdjustmentMode) -> Attribute {
        return .set(#selector(setter: UIView.tintAdjustmentMode), to: v)
    }
    public static func isUserInteractionEnabled(_ v: Int) -> Attribute {
        return .set(#selector(setter: UIView.isUserInteractionEnabled), to: v)
    }
    public static func isExclusiveTouch(_ v: Int) -> Attribute {
        return .set(#selector(setter: UIView.isExclusiveTouch), to: v)
    }
    public static func autoresizingMask(_ v: UIViewAutoresizing) -> Attribute {
        return .set(#selector(setter: UIView.autoresizingMask), to: v)
    }
    public static func transform(_ v: CGAffineTransform) -> Attribute {
        return .set(#selector(setter: UIView.transform), to: v)
    }

}


// CALayer
extension Attribute {

    public struct Layer {

        public static func cornerRadius(_ v: CGFloat) -> Attribute {
            return .setLayer(#selector(setter: CALayer.cornerRadius), to: v)
        }
        public static func masksToBounds(_ v: Bool) -> Attribute {
            return .setLayer(#selector(setter: CALayer.masksToBounds), to: v)
        }
        public static func transform(_ v: CATransform3D) -> Attribute {
            return .setLayer(#selector(setter: CALayer.transform), to: v)
        }
        public static func setAffineTransform(_ v: CGAffineTransform) -> Attribute {
            return .setLayer(#selector(CALayer.setAffineTransform), to: v)
        }
        public static func mask(_ v: CALayer) -> Attribute {
            return .setLayer(#selector(setter: CALayer.mask), to: v)
        }
        public static func isOpaque(_ v: Bool) -> Attribute {
            return .setLayer(#selector(setter: CALayer.isOpaque), to: v)
        }
        public static func allowsEdgeAntialiasing(_ v: Bool) -> Attribute {
            return .setLayer(#selector(setter: CALayer.allowsEdgeAntialiasing), to: v)
        }
        public static func borderWidth(_ v: CGFloat) -> Attribute {
            return .setLayer(#selector(setter: CALayer.borderWidth), to: v)
        }
        public static func borderColor(_ v: CGColor?) -> Attribute {
            return .setLayer(#selector(setter: CALayer.borderColor), to: v)
        }
        public static func opacity(_ v: Float) -> Attribute {
            return .setLayer(#selector(setter: CALayer.opacity), to: v)
        }
        public static func shadowColor(_ v: CGColor?) -> Attribute {
            return .setLayer(#selector(setter: CALayer.shadowColor), to: v)
        }
        public static func shadowOpacity(_ v: Float) -> Attribute {
            return .setLayer(#selector(setter: CALayer.shadowOpacity), to: v)
        }
        public static func shadowOffset(_ v: CGSize) -> Attribute {
            return .setLayer(#selector(setter: CALayer.shadowOffset), to: v)
        }
        public static func shadowRadius(_ v: CGFloat) -> Attribute {
            return .setLayer(#selector(setter: CALayer.shadowRadius), to: v)
        }
        public static func shadowPath(_ v: CGPath?) -> Attribute {
            return .setLayer(#selector(setter: CALayer.shadowPath), to: v)
        }
        public static func name(_ v: String?) -> Attribute {
            return .setLayer(#selector(setter: CALayer.name), to: v)
        }
    }

}
