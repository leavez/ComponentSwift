//
//  AnimatedComponent.swift
//  ComponentSwiftDemo
//
//  Created by Gao on 5/16/17.
//  Copyright © 2017 leave. All rights reserved.
//

import Foundation
import ComponentSwift
import WrapExisted


class AnimatedComponent: CompositeComponent, CKWComponentInitialStateProtocol, CKWComponentAnimationProtocol {

    typealias StateType = Bool

    var textComponent: Component?

    convenience init?(model:Any) {

        let scope = StateScope(with: type(of: self))
        var text: Component?

        self.init(scope: scope) { (state) -> Component? in

            text = TextComponent(
                CKWTextAttributes().build({
                    $0.attributedString = getText()
                    $0.maximumNumberOfLines = state ? 0 : 4
                    $0.truncationAttributedString = NSAttributedString(string:"...")
                }),
                viewAttributes:
                CKWViewAttributeMap(
                    .tapGesture(#selector(didTap))
                )
            )

            return InsetComponent(insets: UIEdgeInsetsMake(20, 100, 20, 20),
                                  component:text)
        }

        self.textComponent = text
    }

    static func initialState() -> Bool {
        return false
    }

    @objc func didTap(sender: Any) {
        print("tapped")

        self.updateState({ (state) -> Bool in
            !state
        }, asynchronously: true)

    }


    func animationsOnInitialMount() -> [CKWComponentAnimation]? {

        return self.animations(fromPreviousComponent: nil)
    }

    func animations(fromPreviousComponent previousComponent: Component?) -> [CKWComponentAnimation]? {
        guard let textComponent = textComponent else {
            return nil
        }

        let scale = CABasicAnimation(keyPath: "transform.scale")
        scale.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
        scale.duration = 1
        scale.fromValue = 0.01
        scale.toValue = 1

        let fade = CABasicAnimation(keyPath: "opacity")
        fade.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
        fade.duration = 1
        fade.fromValue = 0
        fade.toValue = 1

        return [
            ComponentAnimation(component: textComponent, animation: scale),
            ComponentAnimation(component: textComponent, animation: fade)
            ]
    }
    
}

