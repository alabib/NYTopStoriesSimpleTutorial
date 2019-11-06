//
//  TopStoriesDetailsPresenter.swift
//  NYTopStoriesSimpleTutorial
//
//  Created by Ahmed Labib on 06.11.19.
//  Copyright © 2019 Ahmed Labib. All rights reserved.
//

import Foundation

class TopStoriesDetailsPresenter {
    
    private weak var display: TopStoriesDetailsDisplay?
    private let story: TopStoriesResult?
    
    init(for display: TopStoriesDetailsDisplay,
         story: TopStoriesResult?) {
        self.display = display
        self.story = story
        setupUIElements()
    }
    
    
    private func setupUIElements() {
        
        self.display?.setNavigationTitle(story?.section ?? "")
        self.display?.setTitleLabel(with: story?.title ?? "")
        self.display?.setAuthorLabel(with: story?.byline ?? "")
        self.display?.setDescriptionLabel(with: story?.abstractField ?? "")
        
        guard
            let urlString = story?.multimedia.first(where: { $0.formatType == .superJumbo })?.url,
            let imageURL = URL(string: urlString) else {
                return
        }
        self.display?.setImage(with: imageURL)
    }
    
}
