//
//  ChangeSet+Convenience.swift
//  Pods
//
//  Created by Gao on 21/05/2017.
//
//

import Foundation

extension ChangeSet: Builder {
}
extension ChangeSet {

    // NOTE: all method will override the previous result of the same kind action

    // MARK:- insert & update

    public func with(insertedItems : [(indexPath: IndexPath, model: Any?)]?) {
        self.insertedItems = convert(items: insertedItems)
    }
    public func with(updatedItems : [(indexPath: IndexPath, model: Any?)]?) {
        self.updatedItems = convert(items: updatedItems)
    }

    // MARK:- remove

    public func with(removedIndex: CountableRange<Int>, in section: Int = 0) {
        self.removedItems = Set(removedIndex.map{ IndexPath(row:$0, section:section) })
    }
    public func with(removedIndex: CountableClosedRange<Int>, in section: Int = 0) {
        self.removedItems = Set(removedIndex.map{ IndexPath(row:$0, section:section) })
    }


    // MARK:- insert sections

    public func with(insertedSectionAt: Int) {
        self.insertedSections = IndexSet(integer: insertedSectionAt)
    }
    public func with(insertedSections: CountableRange<Int>) {
        self.insertedSections = IndexSet(integersIn: insertedSections)
    }
    public func with(insertedSections: CountableClosedRange<Int>) {
        self.insertedSections = IndexSet(integersIn: insertedSections)
    }

    // MARK:- remove sections

    public func with(removedSectionAt: Int) {
        self.removedSections = IndexSet(integer: removedSectionAt)
    }
    public func with(removedSections: CountableRange<Int>) {
        self.removedSections = IndexSet(integersIn: removedSections)
    }
    public func with(removedSections: CountableClosedRange<Int>) {
        self.removedSections = IndexSet(integersIn: removedSections)
    }


    // private
    private func convert(items:[(indexPath: IndexPath, model: Any?)]?) -> [IndexPath: Any]? {
        guard let items = items else {
            return nil
        }
        var dict: [IndexPath: Any] = [:]
        items.forEach { (index, model) in
            if let model = model {
                dict[index] = model
            }
        }
        return dict
    }
}
