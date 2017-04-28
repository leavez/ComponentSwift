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

                CenterLayoutComponent(
                    child:
                    TextComponent(
                        CKWTextAttributes().build ({
                            $0.attributedString = NSAttributedString(string: "Hello world")
                        })
                    ),

//                    Component(view:
//                        ViewConfiguration(
//                            attributes:
//                            .set( #selector(setter: UIView.backgroundColor), to:UIColor.cyan ),
//                            .setLayer( #selector(setter: CALayer.cornerRadius), to: 30 ),
//                            .tapGesture( #selector(didTap) )
//
//                    ), size: .size(100, 100)),
                    size: nil)

        ))
    }

    @objc func didTap() {
        print("tapped")
    }


}





