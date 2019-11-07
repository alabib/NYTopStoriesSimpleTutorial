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
    
    private let storyCellModels: [StoryCellModel]
    private let onSelection: TopStoriesListOnSelectionHandler?
    
    init(storyCellModels: [StoryCellModel],
         onSelection: TopStoriesListOnSelectionHandler? = nil) {
        self.storyCellModels = storyCellModels
        self.onSelection = onSelection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storyCellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.nyDequeueReusableCell(for: indexPath, cellType: StoriesTableViewCell.self)
        
        cell.configure(with: storyCellModels[indexPath.row])
        
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
