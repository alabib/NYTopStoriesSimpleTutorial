//
//  StoryBrowserWebViewDelegate.swift
//  NYTopStoriesSimpleTutorial
//
//  Created by Ahmed Labib on 07.11.19.
//  Copyright © 2019 Ahmed Labib. All rights reserved.
//

import UIKit
import WebKit

typealias StartNavigationHandler = (() -> Void)
typealias FinishedNavigationHandler = (() -> Void)

class StoryBrowserWebViewDelegate: NSObject, WKNavigationDelegate {
    
    private let onStart: StartNavigationHandler?
    private let didFinish: FinishedNavigationHandler?
    
    init(onStart: StartNavigationHandler? = nil,
         didFinish: FinishedNavigationHandler? = nil) {
        self.onStart = onStart
        self.didFinish = didFinish
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        guard let onStart = onStart else {
            return
        }
        
        onStart()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        guard let didFinish = didFinish else {
            return
        }
        
        didFinish()
    }
}
