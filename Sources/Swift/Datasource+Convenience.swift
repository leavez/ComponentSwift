//
//  Datasource+Convenience.swift
//  Pods
//
//  Created by Gao on 06/05/2017.
//
//

import Foundation

public enum SizeFlexibility {
    case fixed(CGFloat, CGFloat) // parameter is the fixed width, height
    case flexibleWidth(height: CGFloat)  // parameter is the fixed height
    case flexibleHeight(width: CGFloat) // parameter is the fixed width
    case flexibleWidthAndHeight

    fileprivate func sizeRange() -> CGSizeRange {
        switch self {
        case .fixed(let w, let h):
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
    /// - Parameters:
    ///   - componentProvider: where you provide components for models
    ///   - context: the context passed to componentProvider protocol
    ///   - componentSizeFlexibility: the flexibility of component provided by componentProvider. `.flexibleHeight(width:)` means component could have different height, but width is fixed.
    public convenience init(collectionView: UICollectionView,
                supplementaryViewDataSource: SupplementaryViewDataSource? = nil,
                componentProvider: ComponentProviderProtocol.Type,
                context: Any?,
                componentSizeFlexibility: SizeFlexibility? = nil ) {

        let sizes = (componentSizeFlexibility ?? SizeFlexibility.flexibleHeight(width: screenWidth()) ).sizeRange()
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
    /// - Parameters:
    ///   - componentProvider: where you provide components for models
    ///   - context: the context passed to componentProvider protocol
    ///   - tableWidth: the table view's width when table is visible. Nil means using the window width (support split view mode on iPad)
    public convenience init(tableView: UITableView,
                componentProvider: ComponentProviderProtocol.Type,
                context: Any?,
                tableWidth: CGFloat? = nil,
                supplementaryViewDataSource: TableViewSupplementaryDataSource? = nil,
                cellConfiguration: TableViewCellConfiguration = .noAnimationConfig )
    {

        let sizes = SizeFlexibility.flexibleHeight(width: tableWidth ?? screenWidth()).sizeRange()
        let configuration = DataSourceConfiguration(componentProvider: componentProvider, context: context, sizeRange: sizes)

        self.init(tableView: tableView, configuration: configuration, supplementaryViewDataSource:supplementaryViewDataSource, cellConfiguration: cellConfiguration)
    }


    public func apply(_ changeset: ChangeSet,
                      asynchronously: Bool,
                      cellConfiguration:TableViewCellConfiguration? = nil) {
        self.__applyChangeset(changeset, asynchronously: asynchronously, cellConfiguration: cellConfiguration)
    }

    public func update(width:CGFloat, asynchronously: Bool) {
        let sizes = SizeFlexibility.flexibleHeight(width: width).sizeRange()
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

private func screenWidth() -> CGFloat {
    return UIApplication.shared.statusBarFrame.width
}
