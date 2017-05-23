//
//  ViewController.swift
//  CKWrapperDemo
//
//  Created by Gao on 22/04/2017.
//  Copyright © 2017 leave. All rights reserved.
//

import UIKit
import ComponentSwift

struct Context {

}


class CollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var datasource: CSCollectionViewDataSource!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.collectionView);
        self.collectionView.frame = self.view.bounds
        self.collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.collectionView.backgroundColor = .orange

        self.datasource = CSCollectionViewDataSource(collectionView: collectionView, componentProvider: Provider.self, context: Context())
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
