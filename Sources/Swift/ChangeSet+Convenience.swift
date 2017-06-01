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

    @discardableResult
    public func with(insertedItems : [(indexPath: IndexPath, model: Any?)]?) -> ChangeSet {
        self.insertedItems = convert(items: insertedItems)
        return self
    }
    @discardableResult
    public func with(updatedItems : [(indexPath: IndexPath, model: Any?)]?) -> ChangeSet {
        self.updatedItems = convert(items: updatedItems)
        return self
    }

    // MARK:- remove

    @discardableResult
    public func with(removedItems: [IndexPath]) -> ChangeSet {
        self.removedItems = Set(removedItems)
        return self
    }
    @discardableResult
    public func with(removedIndex: CountableRange<Int>, in section: Int = 0) -> ChangeSet {
        self.removedItems = Set(removedIndex.map{ IndexPath(row:$0, section:section) })
        return self
    }
    @discardableResult
    public func with(removedIndex: CountableClosedRange<Int>, in section: Int = 0) -> ChangeSet {
        self.removedItems = Set(removedIndex.map{ IndexPath(row:$0, section:section) })
        return self
    }

    // MARK:- insert sections

    @discardableResult
    public func with(insertedSectionAt: Int) -> ChangeSet {
        self.insertedSections = IndexSet(integer: insertedSectionAt)
        return self
    }
    @discardableResult
    public func with(insertedSections: CountableRange<Int>) -> ChangeSet {
        self.insertedSections = IndexSet(integersIn: insertedSections)
        return self
    }
    @discardableResult
    public func with(insertedSections: CountableClosedRange<Int>) -> ChangeSet {
        self.insertedSections = IndexSet(integersIn: insertedSections)
        return self
    }

    // MARK:- remove sections

    @discardableResult
    public func with(removedSectionAt: Int) -> ChangeSet {
        self.removedSections = IndexSet(integer: removedSectionAt)
        return self
    }
    @discardableResult
    public func with(removedSections: CountableRange<Int>) -> ChangeSet {
        self.removedSections = IndexSet(integersIn: removedSections)
        return self
    }
    @discardableResult
    public func with(removedSections: CountableClosedRange<Int>) -> ChangeSet {
        self.removedSections = IndexSet(integersIn: removedSections)
        return self
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
