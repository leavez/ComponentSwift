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


class SwiftComponent: CompositeComponent, ComponentInitialStateProtocol {

    typealias StateType = Bool


    convenience init?(model:Any) {

        let scope = StateScope(with: type(of: self))

        self.init(scope: scope) { (state) -> Component? in

            InsetComponent(insets: UIEdgeInsetsMake(20, 20, 20, 20),
                           component:

                HorizontalStackComponnet(
                    style:
                    StackLayoutStyle()
                        .spacing(15),

                    children:
                    Component(
                        view:
                        ViewConfiguration(
                            attributes:
                            .set(#selector(setter:UIView.backgroundColor), to: UIColor.orange),
                            .roundCorner(raidus: 30),
                            .tapGesture(#selector(didTap))
                        ),
                        size:.size(60, 60)
                    ),

                    TextComponent(
                        TextAttributes().build({
                            $0.attributedString = getText()
                            $0.maximumNumberOfLines = state ? 0 : 4
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
        }

    }

    static func initialState() -> Bool {
        return false
    }

    @objc func didTap(sender: Any) {
        print("tapped")

        self.updateState({ !$0 }, asynchronously: true)
    }

}




func getText() -> NSAttributedString {
    let text = "I/O Extended events include a variety of options for developers—from live streaming sessions to local demos, hackathons, codelabs, and more. These events are hosted in your neighborhood by local developer communities."
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.hyphenationFactor = 1
    let attributeString = NSAttributedString(string: text, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14), NSParagraphStyleAttributeName: paragraphStyle])
    return attributeString
}



