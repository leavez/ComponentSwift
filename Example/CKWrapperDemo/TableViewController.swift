//
//  TableViewController.swift
//  CKWrapperDemo
//
//  Created by Gao on 16/05/2017.
//  Copyright © 2017 leave. All rights reserved.
//

import UIKit
import ComponentSwift

class TableViewController: UIViewController, UITableViewDelegate, ComponentProvider {

    let tableView = UITableView()
    var datasource: CKWTableViewDatasource!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.tableView);
        self.tableView.frame = self.view.bounds
        self.tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.tableView.backgroundColor = .orange

        self.datasource = CKWTableViewDatasource(tableView: tableView, componentProvider: type(of:self), context: Context())
        self.tableView.delegate = self

        // add a header
        let header = UILabel()
        header.text = "I'm a tableView header."
        header.frame = CGRect(x: 0, y: 0, width: 0, height: 100)
        header.textAlignment = .center
        header.backgroundColor = .lightGray
        header.textColor = .white
        header.layer.cornerRadius = 20
        header.layer.masksToBounds = true
        self.tableView.tableHeaderView = header
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let changeset = ChangeSet<AnyObject>()
        changeset.insertedSections = [0]
        var insetItem: [IndexPath: AnyObject] = [:]
        for i in (0..<100) {
            insetItem[[0, i]] = 1 as AnyObject
        }
        changeset.insertedItems = insetItem

        self.datasource.apply(changeset, asynchronously: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.datasource.sizeForItem(at: indexPath).height
    }


    static func ckwComponent(forModel model: Any, context: Any?) -> Component? {

        return CompositeComponent(
            view:
            CKWViewConfiguration(
                attributes:
                A.backgroundColor(.white)
            ),
            component:
            AnimatedComponent(model: 0)
        )
    }
}
