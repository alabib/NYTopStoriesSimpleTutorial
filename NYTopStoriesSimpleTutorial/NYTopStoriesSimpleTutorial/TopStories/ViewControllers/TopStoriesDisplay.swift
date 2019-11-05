//
//  TopStoriesDisplay.swift
//  NYTopStoriesSimpleTutorial
//
//  Created by Ahmed Labib on 04.11.19.
//  Copyright © 2019 Ahmed Labib. All rights reserved.
//

import Foundation

protocol TopStoriesDisplay: class {
    
    func setTableDelegateAndDatasource(with listDataProvider:TopStoriesListDataProvider)
}
