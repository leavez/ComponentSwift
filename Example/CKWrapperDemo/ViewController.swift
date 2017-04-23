//
//  ViewController.swift
//  CKWrapperDemo
//
//  Created by Gao on 22/04/2017.
//  Copyright © 2017 leave. All rights reserved.
//

import UIKit
import CKWrapper

class ViewController: UIViewController, UITableViewDelegate, FakeCKComponentProvider {

    let tableView = UITableView()
    var datasource :CKDatasourceWrapper!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.tableView);
        self.tableView.frame = self.view.bounds
        self.tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.tableView.backgroundColor = .orange

        self.datasource = CKDatasourceWrapper(tableView: self.tableView, width: UIScreen.main.bounds.width, componentProvider: type(of:self), cellConfig: nil, context: nil, supplementaryDataSource: nil)
        self.tableView.delegate = self
        self.tableView.reloadData()
        self.tableView.tableFooterView = UIView()

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let changeset = CKChangeSetWrapper()
        changeset.insertedSections = [0]
        var insetItem: [IndexPath: NSObjectProtocol] = [:]
        for i in (0..<1) {
            insetItem[[0, i]] = NSObject()
        }
        changeset.insertedItems = insetItem
        self.datasource.applyChangeset(changeset, asynchronized: false)

        let changeset2 = CKChangeSetWrapper()
        var insetItem2: [IndexPath: NSObjectProtocol] = [:]
        for i in (0..<1) {
            insetItem2[[0, i]] = NSObject()
        }
        changeset2.updatedItems  = insetItem2
        self.datasource.applyChangeset(changeset2, asynchronized: false)
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.datasource.sizeForItem(at: indexPath).height
    }


    public static func componentWrapper(forModel model: NSObjectProtocol, context: NSObjectProtocol?) -> Any? {

        return SwiftComponent(model: 1)
    }
}


extension CKWViewClass {
    convenience init(_ cls: AnyClass) {
        self.init(cls:cls)
    }
}

extension CKWViewAttribute {
    convenience init(_ setter: Selector) {
        self.init(setter: setter)
    }
}

extension CKWViewConfiguration {
    convenience init(_ cls: AnyClass, _ attributes:[CKWViewAttribute: Any]?) {
        self.init(viewClass: CKWViewClass(cls), viewAttributeMap: attributes)
    }
    convenience init(_ cls: AnyClass,
                     _ attributes:[Selector: Any]? = nil,
                     layerAttributes:[Selector: Any]? = nil,
                     gestures:[CKWGestureAttribute]? = nil
        ) {

        var converted: [CKWViewAttribute: Any]?
        if let attributes = attributes, attributes.count > 0 {
            var attrs: [CKWViewAttribute: Any] = [:]
            for (key,value) in attributes {
                attrs[CKWViewAttribute(setter: key)] = value
            }
            converted = attrs
        }
        if let layerAttributes = layerAttributes, layerAttributes.count > 0 {
            converted = converted ?? [:]
            for (key,value) in layerAttributes {
                converted?[CKWViewAttribute(layerSetter:key)] = value
            }
        }
        if let gestures = gestures, gestures.count > 0 {
            converted = converted ?? [:]
            for g in gestures {
                converted?[g] = 0 // we don't use the value
            }
        }
        self.init(viewClass: CKWViewClass(cls), viewAttributeMap: converted)
    }
}


protocol Builder {}
extension Builder where Self: AnyObject {

    func b(_ block: (Self) -> Void) -> Self {
        block(self)
        return self
    }
}
extension CKWCreatorBase : Builder {}
