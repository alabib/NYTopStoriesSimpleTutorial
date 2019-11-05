//
//  TopStoriesPresenter.swift
//  NYTopStoriesSimpleTutorial
//
//  Created by Ahmed Labib on 04.11.19.
//  Copyright © 2019 Ahmed Labib. All rights reserved.
//

import Foundation

class TopStoriesPresenter {
    
    private weak var display: TopStoriesDisplay?
    private let serverManager: ServerManager
    init(for display: TopStoriesDisplay,
         serverManager: ServerManager = ServerManager()) {
        self.display = display
        self.serverManager = serverManager
        fetchTopStories()
    }
    
    
    func fetchTopStories() {
        serverManager.getTopStories()
        serverManager.didFinish =
            { [weak self] json in
                guard let obj = json as? TopStories else {
                    return
                }
                let manager = TopStoriesDataManager()
                obj.results.forEach{manager.add($0)}
                self?.display?.get(manager: manager)
        }
        serverManager.didFinishWithError =
            { webserviceError, error in
                print("\n\n===========Error===========")
        }
        
    }
}
