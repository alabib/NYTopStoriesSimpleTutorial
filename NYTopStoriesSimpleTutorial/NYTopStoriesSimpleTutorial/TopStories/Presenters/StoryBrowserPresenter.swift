//
//  StoryBrowserPresenter.swift
//  NYTopStoriesSimpleTutorial
//
//  Created by Ahmed Labib on 07.11.19.
//  Copyright © 2019 Ahmed Labib. All rights reserved.
//

import Foundation

class StoryBrowserPresenter {
    
    private weak var display: StoryBrowserDisplay?
    private let descriptor: TopStoriesDescriptive
    private let url: URL
    
    private var webViewDelegate: StoryBrowserWebViewDelegate?
    
    init(for display: StoryBrowserDisplay,
         descriptor: TopStoriesDescriptive = TopStoriesDescriptor(),
         url: URL) {
        
        self.display = display
        self.url = url
        self.descriptor = descriptor
        self.display?.setNavigationTitle(descriptor.storyBrowserNavigationTitle())
        self.display?.addUIElements()
        createWebViewDelegate()
        self.display?.loadWebView(with: URLRequest(url: url))
    }
    
    
    private func createWebViewDelegate() {
        
        // TODO: Add Loading indicator
        webViewDelegate = StoryBrowserWebViewDelegate()
        
        guard let webViewDelegate = webViewDelegate else {
            return
        }
        
        self.display?.setWebViewDelegate(webViewDelegate)
    }
}
