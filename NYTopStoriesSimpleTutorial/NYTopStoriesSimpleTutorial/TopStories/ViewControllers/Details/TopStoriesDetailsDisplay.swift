//
//  TopStoriesDetailsDisplay.swift
//  NYTopStoriesSimpleTutorial
//
//  Created by Ahmed Labib on 06.11.19.
//  Copyright © 2019 Ahmed Labib. All rights reserved.
//

import UIKit

protocol TopStoriesDetailsDisplay: class {
    
    func setNavigationTitle(_ title: String)
    func setTitleLabel(with title: String)
    func setImage(with url: URL)
    func setAuthorLabel(with author: String)
    func setDescriptionLabel(with description: String)
}
