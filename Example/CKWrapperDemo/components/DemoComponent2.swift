//
//  DemoComponent2.swift
//  ComponentSwiftDemo
//
//  Created by Gao on 18/06/2017.
//  Copyright © 2017 leave. All rights reserved.
//

import Foundation
import ComponentSwift

class DemoComponent2: CompositeComponent {

    init?() {
        super.init(component:
            HorizontalStackComponent(
                Component(view: nil, size: .width(20)),
                cuteRobot()
                )
        )
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



func Color(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat) -> UIColor {
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
}
