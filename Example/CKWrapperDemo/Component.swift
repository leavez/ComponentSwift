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


    init?(model:Any) {

        let scope = StateScope(with: type(of: self))

        super.init(scope: scope) { (state) -> Component? in

            InsetComponent(insets: UIEdgeInsetsMake(20, 20, 20, 20),
                           component:

                VerticalStackComponnet(
                    style:
                    StackLayoutStyle()
                        .spacing(15),

                    children:

                    HorizontalStackComponnet(
                        // circle
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
                        // 
                        Component(view: nil, size: .width(15)),
                        //
                        cuteRobot()
                    ),

                    TextComponent(
                        TextAttributes().build({
                            $0.attributedString = getText()
                            $0.maximumNumberOfLines = state ? 0 : 3
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

private func cuteRobot() -> Component {
    return StaticLayoutComponent(
        view:
        ViewConfiguration(
            attributes:
            A.backgroundColor(Color(248,174,201)),
            A.roundCorner(raidus: 3)
        ),
        children:[
            StaticLayoutChild().build({
                $0.component = Component(view: ViewConfiguration(attributes:A.backgroundColor(Color(23,70,98))), size: .size(20,20))
                $0.position = CGPoint(x: 10, y: 0)
            }),
            StaticLayoutChild().build({
                $0.component = Component(view: ViewConfiguration(attributes:A.backgroundColor(Color(23,70,98))), size: .size(15,20))
                $0.position = CGPoint(x: 200, y: 0)
            }),
            StaticLayoutChild().build({
                $0.component = Component(view: ViewConfiguration(attributes:A.backgroundColor(Color(33,90,127))), size: .size(44,44))
                $0.position = CGPoint(x: 100, y: 30)
            })
        ]
    )
}



func getText() -> NSAttributedString {
    let text = "I/O Extended events include a variety of options for developers—from live streaming sessions to local demos, hackathons, codelabs, and more. These events are hosted in your neighborhood by local developer communities."
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.hyphenationFactor = 1
    let attributeString = NSAttributedString(string: text, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14), NSParagraphStyleAttributeName: paragraphStyle])
    return attributeString
}

func Color(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat) -> UIColor {
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
}


