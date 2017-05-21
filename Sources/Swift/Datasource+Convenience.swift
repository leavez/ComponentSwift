//
//  Datasource+Convenience.swift
//  Pods
//
//  Created by Gao on 06/05/2017.
//
//

import Foundation

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
                sizeFlexibility: CKWSizeFlexibility? = nil ) {

        let sizes = (sizeFlexibility ?? CKWSizeFlexibility.flexibleHeight(screenWidth(collectionView)) ).sizeRange()
        self.init(__collectionView: collectionView, supplementaryViewDataSource: supplementaryViewDataSource, componentProvider: componentProvider, context: context, minSize:sizes.min , maxSize:sizes.max)
    }

    public func apply(_ changeset: ChangeSet, asynchronously: Bool, userInfo:[AnyHashable:Any]? = nil) {
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
                sizeFlexibility: CKWSizeFlexibility? = nil) {


        let sizes = (sizeFlexibility ?? CKWSizeFlexibility.flexibleHeight(screenWidth(tableView)) ).sizeRange()
        self.init(__tableView: tableView, supplementaryViewDataSource: supplementaryViewDataSource, componentProvider: componentProvider, context: context, cellConfiguration:cellConfiguration, minSize:sizes.min , maxSize:sizes.max)
    }


    public func apply(_ changeset: ChangeSet,
                      asynchronously: Bool,
                      cellConfiguration:CKWTableViewCellConfiguration? = nil) {
        self.__applyChangeset(changeset, asynchronously: asynchronously, cellConfiguration: cellConfiguration)
    }


    
}

private func screenWidth(_ view: UIView) -> CGFloat {
    return UIApplication.shared.delegate?.window??.bounds.width ?? view.bounds.width
}
