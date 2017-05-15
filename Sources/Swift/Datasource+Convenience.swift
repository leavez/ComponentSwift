//
//  Datasource+Convenience.swift
//  Pods
//
//  Created by Gao on 06/05/2017.
//
//

import Foundation

extension ChangeSet: Builder {
}

public enum CKWSizeFlexibility {
    case none(CGFloat, CGFloat) // parameter is the fixed width, height
    case flexibleWidth(CGFloat)  // parameter is the fixed height
    case flexibleHeight(CGFloat) // parameter is the fixed width
    case flexibleWidthAndHeight

    fileprivate func sizeRange() -> (min:CGSize, max:CGSize) {
        switch self {
        case .none(let w, let h):
            let size = CGSize(width: w, height: h)
            return (size, size)
        case .flexibleWidth(let h):
            return (CGSize(width: 0, height: h), CGSize(width: .infinity, height: h))
        case .flexibleHeight(let w):
            return (CGSize(width: w, height: 0), CGSize(width: w, height: .infinity))
        case .flexibleWidthAndHeight:
            return (CGSize(width: 0, height: 0), CGSize(width: CGFloat.infinity, height: .infinity))
        }
    }
}


extension CKWCollectionViewDataSource {

    /// - Note:
    ///    componentProvider must be subclass of NSObject
    ///
    public convenience init(collectionView: UICollectionView,
                supplementaryViewDataSource: CKWSupplementaryViewDataSource? = nil,
                componentProvider: ComponentProvider.Type,
                context: Any?,
                sizeFlexibility: CKWSizeFlexibility ) {

        let sizes = sizeFlexibility.sizeRange()
        self.init(__collectionView: collectionView, supplementaryViewDataSource: supplementaryViewDataSource, componentProvider: componentProvider, context: context, minSize:sizes.min , maxSize:sizes.max)
    }

    public convenience init(collectionView: UICollectionView, componentProvider: ComponentProvider.Type,
                            context: Any?) {

        let width = UIApplication.shared.delegate?.window??.bounds.width ?? collectionView.bounds.width
        self.init(collectionView: collectionView, supplementaryViewDataSource: nil, componentProvider: componentProvider, context: context, sizeFlexibility: .flexibleHeight(width))
    }

    public func apply(changeset: ChangeSet<AnyObject>, asynchronously: Bool, userInfo:[AnyHashable:Any]? = nil) {
        self.__applyChangeset(changeset, asynchronously: asynchronously, userInfo: userInfo)
    }

}


extension CKWTableViewDatasource {

    /// - Note:
    ///    componentProvider must be subclass of NSObject
    ///
    public convenience init(tableView: UITableView,
                supplementaryViewDataSource: CKWTableViewSupplementaryDataSource? = nil,
                componentProvider: ComponentProvider.Type,
                context: Any?,
                cellConfiguration: CKWTableViewCellConfiguration = CKWTableViewCellConfiguration.noAnimationConfig(),
                sizeFlexibility: CKWSizeFlexibility) {


        let sizes = sizeFlexibility.sizeRange()
        self.init(__tableView: tableView, supplementaryViewDataSource: supplementaryViewDataSource, componentProvider: componentProvider, context: context, cellConfiguration:cellConfiguration, minSize:sizes.min , maxSize:sizes.max)
    }

    public convenience init(tableView: UITableView, componentProvider: ComponentProvider.Type,
                            context: Any?) {

        let width = UIApplication.shared.delegate?.window??.bounds.width ?? tableView.bounds.width
        self.init(tableView: tableView, supplementaryViewDataSource: nil, componentProvider: componentProvider, context: context, sizeFlexibility: .flexibleHeight(width))
    }

    public func apply(changeset: ChangeSet<AnyObject>,
                      asynchronously: Bool,
                      cellConfiguration:CKWTableViewCellConfiguration? = nil) {
        self.__applyChangeset(changeset, asynchronously: asynchronously, cellConfiguration: cellConfiguration)
    }
    
}
