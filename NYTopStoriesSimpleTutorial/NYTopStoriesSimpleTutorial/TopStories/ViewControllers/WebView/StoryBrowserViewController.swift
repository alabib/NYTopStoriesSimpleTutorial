//
//  StoryBrowserViewController.swift
//  NYTopStoriesSimpleTutorial
//
//  Created by Ahmed Labib on 06.11.19.
//  Copyright © 2019 Ahmed Labib. All rights reserved.
//

import UIKit
import WebKit

class StoryBrowserViewController: UIViewController {
    
    private var presenter: StoryBrowserPresenter?
    
    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(with url: URL) {
        super.init(nibName: nil, bundle: nil)
        makePresenter(with: url)
    }
    
    private func makePresenter(with url: URL) {
        presenter = StoryBrowserPresenter(for: self,
                                          url: url)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func updateConstraints() {
        
        view.addSubview(webView)
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
    }
    
}

extension StoryBrowserViewController: StoryBrowserDisplay {
    
    func setNavigationTitle(_ title: String) {
        self.title = title
    }
    
    func loadWebView(with request: URLRequest) {
        webView.load(request)
    }
    
    func setWebViewDelegate(_ delegate: StoryBrowserWebViewDelegate) {
        webView.navigationDelegate = delegate
    }
    
    func addUIElements() {
        updateConstraints()
    }
    
}
