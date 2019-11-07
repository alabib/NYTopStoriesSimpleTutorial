//
//  TopStoriesDescriptor.swift
//  NYTopStoriesSimpleTutorial
//
//  Created by Ahmed Labib on 07.11.19.
//  Copyright © 2019 Ahmed Labib. All rights reserved.
//

import Foundation

protocol TopStoriesDescriptive {
    func topStroiesListNavigationTitle() -> String
    func storyBrowserNavigationTitle() -> String
}

// TODO: Use Localized Strings
class TopStoriesDescriptor: TopStoriesDescriptive {
    
    func topStroiesListNavigationTitle() -> String {
        return "Top Stories"
    }
    
    func storyBrowserNavigationTitle() -> String {
        return "Browser"
    }
}
