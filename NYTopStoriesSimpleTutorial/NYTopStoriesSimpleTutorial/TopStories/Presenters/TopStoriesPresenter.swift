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
    private let descriptor: TopStoriesDescriptive
    
    init(for display: TopStoriesDisplay,
         serverManager: ServerManager = ServerManager(),
         descriptor: TopStoriesDescriptive = TopStoriesDescriptor()) {
        self.display = display
        self.serverManager = serverManager
        self.descriptor = descriptor
        self.display?.setNavigationTitle(descriptor.topStroiesListNavigationTitle())
        fetchTopStories()
    }
    
    
    private func fetchTopStories() {
        self.display?.startLoader()
        serverManager.getTopStories()
        serverManager.didFinish =
            { [weak self] json in
                self?.display?.stopLoader()
                guard let obj = json as? TopStories else {
                    return
                }
                self?.createDataManager(with: obj)
                
        }
        serverManager.didFinishWithError =
            { [weak self] webserviceError, error in
                self?.display?.stopLoader()
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
        
        listDataProvider = TopStoriesListDataProvider(dataManager: dataManager, onSelection: { [weak self] (index) in
            
            guard let story = dataManager.story(at: index) else {
                return
            }
            
            self?.display?.navigateToDetails(with: story)
        })
        
        guard let listDataProvider = listDataProvider else {
            return
        }
        self.display?.setTableDelegateAndDatasource(with: listDataProvider)
    }
}
