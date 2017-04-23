//
//  Component.swift
//  CKWrapperDemo
//
//  Created by Gao on 23/04/2017.
//  Copyright © 2017 leave. All rights reserved.
//

import Foundation
import CKWrapper

class SwiftComponent: CKWCompositeComponent {

    init?(model:Any) {
        super.init(component:
            CKWComponent(view:
                CKWViewConfiguration(
                    UIView.self,
                    [ #selector(setter: UIView.backgroundColor) : UIColor.cyan,
                     ],
                    layerAttributes: [
                        #selector(setter: CALayer.cornerRadius) : 50,
                        #selector(setter: CALayer.masksToBounds): true
                    ],
                    gestures: [
                        CKWGestureAttribute(tapAction: #selector(didTap))
                    ]

            ), size: CGSize(width: 100, height: 150))
        )
    }

    @objc func didTap() {
        print("tapped")
    }


}
