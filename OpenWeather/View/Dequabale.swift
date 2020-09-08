//
//  Dequabale.swift
//  OpenWeather
//
//  Created by C.Green on 22/10/2018.
//  Copyright © 2018 Test. All rights reserved.
//

import Foundation
import UIKit.UIView

public protocol Dequeuable: class {
    
    static var dequeueNibName: String { get }
    
    static var dequeueIdentifier: String { get }
}

extension Dequeuable where Self: UIView {
    public static var dequeueIdentifier: String {
        return NSStringFromClass(self)
    }
    public static var dequeueNibName: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}

public extension UITableView {
    
    public func register<T: UITableViewCell>(_ : T.Type) where T: Dequeuable {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.dequeueNibName, bundle: bundle)
        self.register(nib, forCellReuseIdentifier: T.dequeueIdentifier)
    }
    
    public func dequeue<T: UITableViewCell>(reusableCell type:T.Type, for indexPath: IndexPath) -> T where T: Dequeuable {
        guard let cell = dequeueReusableCell(withIdentifier: T.dequeueIdentifier, for: indexPath) as? T else {
            fatalError("Cannot dequeue: \(T.self) with identifier: \(T.dequeueIdentifier)")
        }
        return cell
    }
}
