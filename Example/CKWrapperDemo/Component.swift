//
//  Component.swift
//  CKWrapperDemo
//
//  Created by Gao on 23/04/2017.
//  Copyright © 2017 leave. All rights reserved.
//

import Foundation
import CKWrapper
import WrapExisted


class SwiftComponent: CompositeComponent {

    init?(model:Any) {

        let text = "Even though each migration experience is different depending on your existing codebase, there are some general steps and tools to help you troubleshoot your code migration"

        super.init(component:

            InsetComponent(insets: UIEdgeInsetsMake(20, 20, 20, 20),
                           component:

                StackLayoutComponent(
                    style: CKWStackLayoutStyle().build({
                        $0.spacing = 20
                        $0.direction = .horizontal
                    }), children:[

                        StackLayoutChild(
                            Component(
                                view:
                                CKWViewConfiguration(
                                    UIView.self,
                                    attributeEnums:
                                    .set(#selector(setter:UIView.backgroundColor), to: UIColor.brown),
                                    .roundCorner(raidus: 30),
                                    .masksToBounds(),
                                    .tapGesture(#selector(didTap))
                                ),
                                size:.size(60, 60)
                            )
                        ),

                        StackLayoutChild(
                            TextComponent(
                                CKWTextAttributes(text, font:.systemFont(ofSize: 14))
                            ),
                            flexGrow: true,
                            flexShrink: true
                        )
                    ])
            )
        )
    }

    @objc func didTap(sender: Any) {
        print("tapped")
    }


}





