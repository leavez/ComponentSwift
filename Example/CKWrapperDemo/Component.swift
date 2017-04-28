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
                    sizing: .minimumX,
                    child: CompositeComponent(
                        view:
                        CKWViewConfiguration(
                            attributeEnums:
                            .set( #selector(setter: UIView.backgroundColor), to:UIColor.cyan ),
                            .setLayer( #selector(setter: CALayer.cornerRadius), to: 30 ),
                            .setLayer( #selector(setter: CALayer.masksToBounds), to: true),
                            .tapGesture( #selector(didTap) )
                        ),
                        component:
                        CenterLayoutComponent(child: TextComponent(
                            CKWTextAttributes("Hello World!", font:.systemFont(ofSize: 40))
                        ))

                    )
                    ,
                    size: nil)

        ))
    }

    @objc func didTap() {
        print("tapped")
    }
    
    
}





