//
//  Component.swift
//  CKWrapperDemo
//
//  Created by Gao on 23/04/2017.
//  Copyright © 2017 leave. All rights reserved.
//

import Foundation
import ComponentSwift
import WrapExisted


class SwiftComponent: CompositeComponent {

    init?(model: Int) {
        super.init(component:

            InsetComponent(insets: UIEdgeInsetsMake(20, 20, 20, 20),
                           component:

                // `init(view: ViewConfiguration? = nil,
                //       style: StackLayoutStyle?,
                //       size: LayoutSize? = nil,
                //       children: StackLayoutChildType?...)`
                // is the most recommended initializer for stack component
                HorizontalStackComponent(
                    style:
                    StackLayoutStyle()
                        .spacing(15)
                        .alignItems(.center), // this is a convenient method. Or you could use `StackLayoutStyle().build({ ... })` to create a StackLayoutStyle object

                    children:
                    // The children parameter accept a `StackLayoutChildType`. Both `Component` and `StackLayoutChild` conformed to this protocol.
                    // circle
                    Component(
                        view:
                        ViewConfiguration(
                            attributes:
                            .set(#selector(setter:UIView.backgroundColor), to: UIColor.orange), // or use `.backgroundColor(.orange),`
                            .roundCorner(raidus: 30)
                        ),
                        size:.size(60, 60)
                    ),

                    // text
                    TextComponent(
                        TextAttributes().build({
                            $0.attributedString = getText()
                            $0.maximumNumberOfLines = 3
                            $0.truncationAttributedString = NSAttributedString(string:"...")
                        }),
                        viewAttributes:
                        ViewAttributeMap(
                            .tapGesture(#selector(didTap))
                        )

                    ).stackLayoutChild
                        .flexGrow(true)
                        .flexShrink(true)
                )
            )
        )
    }

    @objc func didTap(sender: Any) {
        print("tapped")
    }

}




func getText() -> NSAttributedString {
    let text = "I/O Extended events include a variety of options for developers—from live streaming sessions to local demos, hackathons, codelabs, and more. These events are hosted in your neighborhood by local developer communities."
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.hyphenationFactor = 1
    let attributeString = NSAttributedString(string: text, attributes: [.font: UIFont.systemFont(ofSize: 14), .paragraphStyle: paragraphStyle])
    return attributeString
}



