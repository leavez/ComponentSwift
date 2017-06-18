//
//  DemoViewController.swift
//  ComponentSwiftDemo
//
//  Created by Gao on 18/06/2017.
//  Copyright © 2017 leave. All rights reserved.
//

import Foundation
import ComponentSwift

class DemoViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var datasource: CSCollectionViewDataSource!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.collectionView);
        self.collectionView.frame = self.view.bounds
        self.collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.collectionView.backgroundColor = .lightGray

        self.datasource = CSCollectionViewDataSource(collectionView: collectionView, componentProvider: type(of: self), context: nil)
        self.collectionView.delegate = self
        self.collectionView.reloadData()


        // add changeset
        let changeset = ChangeSet().build {
            $0.with(insertedSectionAt: 0)
            $0.with(insertedItems: (0..<100).map{ ([0, $0], $0)})
        }

        self.datasource.apply(changeset, asynchronously: true)
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.datasource.sizeForItem(at: indexPath)
    }
}

extension DemoViewController: ComponentProviderProtocol {

    static func csComponent(forModel model: Any, context: Any?) -> Component? {

        guard let model = model as? Int else {
            return nil
        }

        let allCount = 4
        let component: Component?
        switch model % allCount {
        case 0:
            component = DemoComponent(model: model)
        case 1:
            component = DemoComponent2()
        case 2:
            component = DemoComponent3()
        case 3:
            component = DemoComponent4()
        default:
            component = nil
        }

        return

            CompositeComponent(
            view:
            ViewConfiguration(
                attributes:
                A.backgroundColor(.white)
            ),
            component:  component
        )
    }
}
