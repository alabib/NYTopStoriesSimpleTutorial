//
//  UIStoryboard+Creation.swift
//  NYTopStoriesSimpleTutorial
//
//  Created by Ahmed Labib on 06.11.19.
//  Copyright © 2019 Ahmed Labib. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    static func makeViewController<T: UIViewController>(ofType type: T.Type, storyBoardName: String) -> T {
        
        let bundle = Bundle(for: type)
        let storyboard = UIStoryboard(name: storyBoardName, bundle: bundle)
        
        guard let controller = storyboard.instantiateViewController(withIdentifier: String(describing: type)) as? T else {
            fatalError("ViewController \(type) could not be found in \(storyBoardName)")
        }
        
        return controller
    }
}
