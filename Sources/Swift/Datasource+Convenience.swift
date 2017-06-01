//
//  Datasource+Convenience.swift
//  Pods
//
//  Created by Gao on 06/05/2017.
//
//

import Foundation

public enum SizeFlexibility {
    case none(CGFloat, CGFloat) // parameter is the fixed width, height
    case flexibleWidth(CGFloat)  // parameter is the fixed height
    case flexibleHeight(CGFloat) // parameter is the fixed width
    case flexibleWidthAndHeight

    fileprivate func sizeRange() -> CGSizeRange {
        switch self {
        case .none(let w, let h):
            let size = CGSize(width: w, height: h)
            return CGSizeRange(min: size, max: size)
        case .flexibleWidth(let h):
            return CGSizeRange(min: CGSize(width: 0, height: h), max: CGSize(width: .infinity, height: h))
        case .flexibleHeight(let w):
            return CGSizeRange(min: CGSize(width: w, height: 0), max: CGSize(width: w, height: .infinity))
        case .flexibleWidthAndHeight:
            return CGSizeRange(min: CGSize(width: 0, height: 0), max: CGSize(width: CGFloat.infinity, height: .infinity))
        }
    }
}


extension CSCollectionViewDataSource {

    /// - Note:
    ///    componentProvider must be subclass of NSObject
    ///
    public convenience init(collectionView: UICollectionView,
                supplementaryViewDataSource: SupplementaryViewDataSource? = nil,
                componentProvider: ComponentProviderProtocol.Type,
                context: Any?,
                sizeFlexibility: SizeFlexibility? = nil ) {

        let sizes = (sizeFlexibility ?? SizeFlexibility.flexibleHeight(screenWidth(collectionView)) ).sizeRange()
        let configuration = DataSourceConfiguration(componentProvider: componentProvider, context: context, sizeRange: sizes)

        self.init(collectionView: collectionView, supplementaryViewDataSource: supplementaryViewDataSource, configuration: configuration)
    }

    public func apply(_ changeset: ChangeSet, asynchronously: Bool, userInfo:[AnyHashable:Any]? = nil) {
        self.__applyChangeset(changeset, asynchronously: asynchronously, userInfo: userInfo)
    }

    public func update(sizeFlexibility: SizeFlexibility, asynchronously: Bool) {
        let sizes = sizeFlexibility.sizeRange()
        self.__update(sizes, asynchronously: asynchronously)
    }

}


extension CSTableViewDataSource {

    /// - Note:
    ///    componentProvider must be subclass of NSObject
    ///
    public convenience init(tableView: UITableView,
                componentProvider: ComponentProviderProtocol.Type,
                context: Any?,
                sizeFlexibility: SizeFlexibility? = nil,
                supplementaryViewDataSource: TableViewSupplementaryDataSource? = nil,
                cellConfiguration: TableViewCellConfiguration = .noAnimationConfig )
    {

        let sizes = (sizeFlexibility ?? SizeFlexibility.flexibleHeight(screenWidth(tableView)) ).sizeRange()
        let configuration = DataSourceConfiguration(componentProvider: componentProvider, context: context, sizeRange: sizes)

        self.init(tableView: tableView, configuration: configuration, supplementaryViewDataSource:supplementaryViewDataSource, cellConfiguration: cellConfiguration)
    }


    public func apply(_ changeset: ChangeSet,
                      asynchronously: Bool,
                      cellConfiguration:TableViewCellConfiguration? = nil) {
        self.__applyChangeset(changeset, asynchronously: asynchronously, cellConfiguration: cellConfiguration)
    }

    public func update(sizeFlexibility: SizeFlexibility, asynchronously: Bool) {
        let sizes = sizeFlexibility.sizeRange()
        self.__update(sizes, asynchronously: asynchronously)
    }
    
}

extension TableViewCellConfiguration: Builder {}
extension TableViewCellConfiguration {

    public static var noAnimationConfig: TableViewCellConfiguration {
        let config = TableViewCellConfiguration()
        config.animationRowDelete = .none
        config.animationRowInsert = .none
        config.animationSectionDelete = .none
        config.animationSectionInsert = .none
        config.animationsDisabled = true
        return config
    }

    public static func animationConfig(style: UITableViewRowAnimation = .automatic) -> TableViewCellConfiguration {
        let config = TableViewCellConfiguration()
        config.animationRowDelete = style
        config.animationRowInsert = style
        config.animationSectionDelete = style
        config.animationSectionInsert = style
        return config
    }
}

private func screenWidth(_ view: UIView) -> CGFloat {
    return UIApplication.shared.delegate?.window??.bounds.width ?? view.bounds.width
}
