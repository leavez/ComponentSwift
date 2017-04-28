//
//  CenterLayoutComponent+Convenience.swift
//  Pods
//
//  Created by Gao on 28/04/2017.
//
//

import UIKit

extension CenterLayoutComponent {

    public convenience init?(centering: CKWCenterLayoutComponentCenteringOptions = .XY,
                             sizing: CKWCenterLayoutComponentSizingOptions = .minimumXY,
                             child: Component?, size: CKWSize? = nil) {
        self.init(centeringOptions: centering, sizingOptions: sizing, childComponent: child, size: size)
    }
}

extension TextComponent {

    public convenience init(_ textAttributes: CKWTextAttributes,
                            viewAttributes: CKWViewAttributeMap? = nil,
                            options: CKWTextComponentOptions? = nil,
                            size: CKWSize? = nil) {
        self.init(textAttributes: textAttributes, viewAttributes: viewAttributes, options: options, size: size)
    }
}

extension CKWTextAttributes {
    
    public convenience init(_ attributedString: NSAttributedString?) {
        self.init()
        self.attributedString = attributedString
    }
    public convenience init(_ string: String?, attrs: [String : Any]) {
        self.init()
        self.attributedString = string.map{ NSAttributedString(string: $0, attributes: attrs) }
    }
    public convenience init(_ string: String?, font: UIFont = UIFont.systemFont(ofSize: 14)) {
        self.init()
        self.attributedString = string.map{ NSAttributedString(string: $0, attributes: [NSFontAttributeName: font]) }
    }
}
