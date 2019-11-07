//
//  StoryBrowserDisplay.swift
//  NYTopStoriesSimpleTutorial
//
//  Created by Ahmed Labib on 07.11.19.
//  Copyright © 2019 Ahmed Labib. All rights reserved.
//

import Foundation

protocol StoryBrowserDisplay: class {
    
    func setNavigationTitle(_ title: String)
    func addUIElements()
    func loadWebView(with request: URLRequest)
    func setWebViewDelegate(_ delegate: StoryBrowserWebViewDelegate)
}
