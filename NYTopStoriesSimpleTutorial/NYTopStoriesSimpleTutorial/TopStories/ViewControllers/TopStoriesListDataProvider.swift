//
//  TopStoriesDataProvider.swift
//  NYTopStoriesSimpleTutorial
//
//  Created by Ahmed Labib on 05.11.19.
//  Copyright © 2019 Ahmed Labib. All rights reserved.
//

import UIKit

class TopStoriesListDataProvider: NSObject, UITableViewDataSource {
    
    private let dataManager: TopStoriesDataManageable
    
    init(with dataManager: TopStoriesDataManageable) {
        self.dataManager = dataManager
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataManager.storiesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let cell = tableView.nyDequeueReusableCell(for: indexPath, cellType: StoriesTableViewCell.self)
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = self.dataManager.story(at: indexPath.row)?.title
        
        return cell
    }
    
}

extension TopStoriesListDataProvider: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("")
    }
}