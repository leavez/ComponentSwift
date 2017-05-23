//
//  TableViewController.swift
//  CKWrapperDemo
//
//  Created by Gao on 16/05/2017.
//  Copyright © 2017 leave. All rights reserved.
//

import UIKit
import ComponentSwift

class TableViewController: UIViewController, UITableViewDelegate, ComponentProviderProtocol {

    let tableView = UITableView()
    var datasource: TableViewDatasource!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.tableView);
        self.tableView.frame = self.view.bounds
        self.tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.tableView.backgroundColor = .orange

        self.datasource = TableViewDatasource(tableView: tableView, componentProvider: type(of:self), context: Context())
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


        // add changeset
        let changeset = ChangeSet().build {
            $0.with(insertedSectionAt: 0)
            $0.with(insertedItems: (0..<100).map{ ([0, $0], $0)})
        }
        self.datasource.apply(changeset, asynchronously: true)
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.datasource.sizeForItem(at: indexPath).height
    }


    static func ckwComponent(forModel model: Any, context: Any?) -> Component? {

        return CompositeComponent(
            view:
            ViewConfiguration(
                attributes:
                A.backgroundColor(.white)
            ),
            component:
            AnimatedComponent(model: 0)
        )
    }
}
