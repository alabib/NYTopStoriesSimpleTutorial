//
//  UITableView+Extensions.swift
//  NYTopStoriesSimpleTutorial
//
//  Created by Ahmed Labib on 05.11.19.
//  Copyright © 2019 Ahmed Labib. All rights reserved.
//

import UIKit

public protocol NYReusable {}

// MARK: - UITableViewCell

extension UITableViewCell: NYReusable {}

public extension NYReusable where Self: UITableViewCell {
    
    static var nyNib: UINib {
        return UINib(nibName: self.nyReuseIdentifier, bundle: Bundle(for: self))
    }
    
    static var nyReuseIdentifier: String {
        return String(describing: self)
    }
}

// MARK: - UITableView

public extension UITableView {
    
    func nyRegisterClass<T: UITableViewCell>(cellType: T.Type) {
        self.register(cellType, forCellReuseIdentifier: cellType.nyReuseIdentifier)
    }
    
    func nyRegisterNib<T: UITableViewCell>(cellType: T.Type) {
        self.register(T.nyNib, forCellReuseIdentifier: cellType.nyReuseIdentifier)
    }
    
    func nyDequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T {
        
        guard let cell = self.dequeueReusableCell(withIdentifier: cellType.nyReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(cellType.nyReuseIdentifier)")
        }
        
        return cell
    }
}

