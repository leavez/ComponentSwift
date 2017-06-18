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
    var datasource: CSTableViewDataSource!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.tableView);
        self.tableView.frame = self.view.bounds
        self.tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.tableView.backgroundColor = .lightGray

        let cellConfig = TableViewCellConfiguration.noAnimationConfig
        cellConfig.cellConfigurationFunction = { cell, _, _ in
            cell.clipsToBounds = true
        }

        self.datasource = CSTableViewDataSource(tableView: tableView, componentProvider: type(of:self), context: Context(), cellConfiguration: cellConfig)
        self.tableView.delegate = self

        // add a header
        let header = UILabel()
        header.text = "I'm a tableView header\nDemo for animations"
        header.frame = CGRect(x: 0, y: 0, width: 0, height: 100)
        header.textAlignment = .center
        header.backgroundColor = .orange
        header.textColor = .white
        header.layer.cornerRadius = 20
        header.layer.masksToBounds = true
        header.numberOfLines = 0
        self.tableView.tableHeaderView = header


        // add changeset
        let changeset = ChangeSet()
            .with(insertedSectionAt: 0)
            .with(insertedItems: (0..<100).map{ ([0, $0], $0)})
        
        self.datasource.apply(changeset, asynchronously: true)
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.datasource.sizeForItem(at: indexPath).height
    }


    static func csComponent(forModel model: Any, context: Any?) -> Component? {

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
