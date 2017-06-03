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


class AnimatedComponent: CompositeComponent, ComponentStateProtocol, ComponentAnimationProtocol {

    typealias StateType = Bool

    var textComponent: Component!

    init?(model:Any) {

        let scope = StateScope(with: type(of: self), identifier:nil) { true }
        var text: Component?

        super.init(scope: scope) { (state) -> Component? in

            text = TextComponent(
                TextAttributes().build({
                    $0.attributedString = getText()
                    $0.maximumNumberOfLines = state ? 4 : 0
                    $0.truncationAttributedString = NSAttributedString(string:"...")
                }),
                viewAttributes:
                ViewAttributeMap(
                    .tapGesture(#selector(didTap))
                )
            )

            return InsetComponent(insets: UIEdgeInsetsMake(20, 100, 20, 20),
                                  component:text)
        }

        self.textComponent = text
    }


    @objc func didTap(sender: Any) {
        print("tapped")

        self.updateState({ (state) -> Bool in
            !state
        }, asynchronously: true)

    }


    func animationsOnInitialMount() -> [ComponentAnimation]? {

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

    func animations(fromPreviousComponent previousComponent: Component?) -> [ComponentAnimation]? {
        guard let previousComponent = previousComponent as? AnimatedComponent else {
            return nil
        }

        return [
            ComponentAnimation(previousComponent: previousComponent.textComponent, component: textComponent, animation: { (previous, view) in
                // because the cell configuration of datasource is set to noAnimation,
                // which will perform change with uiview animation diabled. so we enable
                // animation here, to allow performing uiview animaiton.
                UIView.setAnimationsEnabled(true)
                view?.alpha = 0
                view?.transform = CGAffineTransform(translationX: 0, y: -50)
                UIView.animate(withDuration: 0.4, animations: {
                    previous?.alpha = 0
                    previous?.transform = CGAffineTransform(translationX: 0, y: 50)
                    view?.alpha = 1
                    view?.transform = .identity
                })
                UIView.setAnimationsEnabled(false)
            })
        ]

    }
    
}

