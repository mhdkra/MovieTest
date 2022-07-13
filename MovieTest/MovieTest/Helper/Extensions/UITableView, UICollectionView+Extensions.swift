//
//  UICollectionView+Extensions.swift
//  MovieTest
//
//  Created by Tiara on 12/07/22.
//

import UIKit
public extension UITableView {
    
    /**
     Register nibs faster by passing the type - if for some reason the `identifier` is different then it can be passed
     - Parameter type: UITableViewCell.Type
     - Parameter identifier: String?
     */
    func registerCell(type: UITableViewCell.Type, identifier: String? = nil) {
        let cellId = String(describing: type)
        register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: identifier ?? cellId)
    }
    
    /**
     DequeueCell by passing the type of UITableViewCell
     - Parameter type: UITableViewCell.Type
     */
    func dequeueCell<T: UITableViewCell>(withType type: UITableViewCell.Type) -> T? {
        return dequeueReusableCell(withIdentifier: type.identifier) as? T
    }
    
    /**
     DequeueCell by passing the type of UITableViewCell and IndexPath
     - Parameter type: UITableViewCell.Type
     - Parameter indexPath: IndexPath
     */
    func dequeueCell<T: UITableViewCell>(withType type: UITableViewCell.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: type.identifier, for: indexPath) as? T
    }
    
}

public extension UITableViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
}

//MARK: - UICOLLECTIONVIEW
extension UICollectionView {
    func registerNIBForCell(with cellClass: AnyClass) {
        let className = String(describing: cellClass)
        self.register(UINib(nibName: className, bundle: nil), forCellWithReuseIdentifier: className)
    }
    
    func dequeueCell<T>(with cellClass: T.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withReuseIdentifier: String(describing: cellClass), for: indexPath) as? T
    }
    
    func registerNIBForHeader(with cellClass: AnyClass) {
        let className = String(describing: cellClass)
        self.register(UINib(nibName: className, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: className)
    }
    
    func dequeueHeader<T>(with cellClass: T.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: cellClass), for: indexPath) as? T
    }
    
    func registerNIBForFooter(with cellClass: AnyClass) {
        let className = String(describing: cellClass)
        self.register(UINib(nibName: className, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: className)
    }
    
    func dequeueFooter<T>(with cellClass: T.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: String(describing: cellClass), for: indexPath) as? T
    }
}
