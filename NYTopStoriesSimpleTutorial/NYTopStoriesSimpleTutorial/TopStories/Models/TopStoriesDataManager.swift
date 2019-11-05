//
//  TopStoriesDataManager.swift
//  NYTopStoriesSimpleTutorial
//
//  Created by Ahmed Labib on 04.11.19.
//  Copyright © 2019 Ahmed Labib. All rights reserved.
//

import Foundation

protocol TopStoriesDataManageable {
    var storiesCount: Int { get }
    func add(_ story: TopStoriesResult)
    func story(at index: Int) -> TopStoriesResult?
}

class TopStoriesDataManager: TopStoriesDataManageable {
    
    private var topStories: [TopStoriesResult] = []
    
    var storiesCount: Int {
        return topStories.count
    }
    
    func add(_ story: TopStoriesResult) {
        if !topStories.contains(story) {
            topStories.append(story)
        }
    }
    
    func story(at index: Int) -> TopStoriesResult? {
        return topStories.indices.contains(index) ? topStories[index] : nil
    }
}
