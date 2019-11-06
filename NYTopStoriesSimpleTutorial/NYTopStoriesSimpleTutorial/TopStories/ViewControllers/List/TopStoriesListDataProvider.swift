//
//  TopStoriesDataProvider.swift
//  NYTopStoriesSimpleTutorial
//
//  Created by Ahmed Labib on 05.11.19.
//  Copyright © 2019 Ahmed Labib. All rights reserved.
//

import UIKit

typealias TopStoriesListOnSelectionHandler = ((Int) -> Void)

class TopStoriesListDataProvider: NSObject, UITableViewDataSource {
    
    private let dataManager: TopStoriesDataManageable
    private let onSelection: TopStoriesListOnSelectionHandler?
    
    init(dataManager: TopStoriesDataManageable,
         onSelection: TopStoriesListOnSelectionHandler? = nil) {
        self.dataManager = dataManager
        self.onSelection = onSelection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataManager.storiesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.nyDequeueReusableCell(for: indexPath, cellType: StoriesTableViewCell.self)
        
        
        guard let story = self.dataManager.story(at: indexPath.row) else {
            return UITableViewCell()
        }
        
        cell.configure(with: story)
        
        return cell
    }
    
}

extension TopStoriesListDataProvider: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let onSelectionClosure = self.onSelection else {
            return
        }
        onSelectionClosure(indexPath.row)
    }
}
