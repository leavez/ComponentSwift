//
//  DemoComponent4.swift
//  ComponentSwiftDemo
//
//  Created by Gao on 18/06/2017.
//  Copyright © 2017 leave. All rights reserved.
//

import Foundation
import ComponentSwift

class DemoComponent4: CompositeComponent {

    init?() {

        let button = ButtonComponnet.Attribute().build { (a) in
            a.titles = [.normal: "Hello, I'm a button !", .highlighted: "You completed me"]
            a.titleColors = [.normal: .black, .highlighted: .lightGray]
            a.titleFont = UIFont.boldSystemFont(ofSize: 20)
        }

        super.init(component:
            CenterLayoutComponent(
                child:
                ButtonComponnet(attributes: button, action: #selector(didTapButton), size: nil),
                size: LayoutSize().build({
                    $0.minHeight = 60
                })
            )
        )
    }

    func didTapButton() {
        print("tap button")
    }
}
