//
//  TopStoriesPresenter.swift
//  NYTopStoriesSimpleTutorial
//
//  Created by Ahmed Labib on 04.11.19.
//  Copyright © 2019 Ahmed Labib. All rights reserved.
//

import UIKit

class TopStoriesPresenter {
    
    private let serverManager: ServerManager
    private weak var display: TopStoriesDisplay?
    private var manager: TopStoriesDataManageable?
    private var listDataProvider: TopStoriesListDataProvider?
    
    init(for display: TopStoriesDisplay,
         serverManager: ServerManager = ServerManager()) {
        self.display = display
        self.serverManager = serverManager
        fetchTopStories()
    }
    
    
    private func fetchTopStories() {
        serverManager.getTopStories()
        serverManager.didFinish =
            { [weak self] json in
                guard let obj = json as? TopStories else {
                    return
                }
                self?.createDataManager(with: obj)
                
        }
        serverManager.didFinishWithError =
            { webserviceError, error in
                print("\n\n===========Error===========")
        }
        
    }
    
    private func createDataManager(with topStoriesObj: TopStories) {
        
        self.manager = TopStoriesDataManager()
        topStoriesObj.results.forEach{self.manager?.add($0)}
        self.createListDataProvider(with: self.manager)
    }
    
    private func createListDataProvider(with dataManager: TopStoriesDataManageable?) {
        
        guard let dataManager = dataManager else {
            return
        }
        
        listDataProvider = TopStoriesListDataProvider(with: dataManager)
        
        guard let listDataProvider = listDataProvider else {
            return
        }
        self.display?.setTableDelegateAndDatasource(with: listDataProvider)
    }
}
