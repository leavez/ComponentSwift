//
//  Component.swift
//  CKWrapperDemo
//
//  Created by Gao on 23/04/2017.
//  Copyright © 2017 leave. All rights reserved.
//

import Foundation
import CKWrapper

class SwiftComponent: CompositeComponent {

    init?(model:Any) {
        super.init(component:
            InsetComponent(
                insets: UIEdgeInsetsMake(20, 20, 20, 20),
                component:
                Component(view:
                    ViewConfiguration(
                        attributes:
                        .set( #selector(setter: UIView.backgroundColor), to:UIColor.cyan ),
                        .setLayer( #selector(setter: CALayer.cornerRadius), to: 30 ),
                        .tapGesture( #selector(didTap) )

                    ),size: .height(100))
        ))
    }

    @objc func didTap() {
        print("tapped")
    }
    
    
}




