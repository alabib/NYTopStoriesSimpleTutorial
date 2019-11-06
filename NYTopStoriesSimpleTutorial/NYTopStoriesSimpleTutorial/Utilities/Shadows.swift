//
//  Shadows.swift
//  NYTopStoriesSimpleTutorial
//
//  Created by Ahmed Labib on 06.11.19.
//  Copyright © 2019 Ahmed Labib. All rights reserved.
//

import UIKit

class Shadows {
    
    static func setupShadowFor(_ view: UIView) {
        view.layer.shadowOpacity = 1
        view.layer.shouldRasterize = true
        view.layer.rasterizationScale = UIScreen.main.scale
        view.layer.shadowColor = UIColor(red: 16/255, green: 6/255, blue: 7/255, alpha: 0.23).cgColor
        view.layer.shadowRadius = 2
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
    }
}

