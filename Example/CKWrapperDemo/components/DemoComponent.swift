//
//  DemoComponent.swift
//  ComponentSwiftDemo
//
//  Created by Gao on 18/06/2017.
//  Copyright © 2017 leave. All rights reserved.
//

import Foundation

import Foundation
import ComponentSwift
import WrapExisted


class DemoComponent: CompositeComponent, ComponentInitialStateProtocol {

    typealias StateType = Bool


    init?(model:Int) {

        let scope = StateScope(with: type(of: self))

        super.init(scope: scope) { (state) -> Component? in

            InsetComponent(insets: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20),
                           component:

                VerticalStackComponent(
                    style:
                    StackLayoutStyle()
                        .spacing(10),

                    children:
                    TextComponent(
                        TextAttributes("Chapter \(model)", font: .boldSystemFont(ofSize: 24))
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
        self.updateState({ !$0 }, asynchronously: true)
    }

}
