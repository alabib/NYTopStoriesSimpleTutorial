//
//  StoryCellModelsFactory.swift
//  NYTopStoriesSimpleTutorial
//
//  Created by Ahmed Labib on 07.11.19.
//  Copyright © 2019 Ahmed Labib. All rights reserved.
//

import Foundation

protocol StoryCellModelsBuilder{
    func buildStoryCellModels(with dataManager: TopStoriesDataManageable) -> [StoryCellModel]?
}

class StoryCellModelsFactory: StoryCellModelsBuilder {
    
    func buildStoryCellModels(with dataManager: TopStoriesDataManageable) -> [StoryCellModel]? {
        
        guard dataManager.storiesCount > 0  else {
            return nil
        }
        
        var storyCellModels = [StoryCellModel]()
        var cellModel: StoryCellModel
        for index in 0 ..< dataManager.storiesCount {
            guard let story = dataManager.story(at: index) else {
                continue
            }
            cellModel = StoryCellModel(title: story.title ?? "",
                                         byline: story.byline ?? "",
                                         thumbnailURL: getThumbnailURL(from: story))
            storyCellModels.append(cellModel)
        }
        
        return storyCellModels
    }
    
    private func getThumbnailURL(from story: TopStoriesResult) -> URL? {
        guard
            let urlString = story.multimedia?.first(where: { $0.formatType == .standard })?.url,
            let imageURL = URL(string: urlString) else {
                return nil
        }
        
        return imageURL
    }
}
