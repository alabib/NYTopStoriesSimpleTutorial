//
//  StoryBrowserPresenterTests.swift
//  NYTopStoriesSimpleTutorialTests
//
//  Created by Ahmed Labib on 07.11.19.
//  Copyright © 2019 Ahmed Labib. All rights reserved.
//

import XCTest
@testable import NYTopStoriesSimpleTutorial

class StoryBrowserPresenterTests: XCTestCase {

    private var subject: StoryBrowserPresenter?
    private var display: MockDisplay!
    
    override func setUp() {
        super.setUp()
        display = MockDisplay()
    }
    
    func testPresenter_SetsNavigationTitle() {
        
        let expectedNavigationTitle = "navigationTitle"
        display.navigationTitle = expectedNavigationTitle
        display.navigationTitleHandler = { navigationTitle in
            XCTAssertEqual(navigationTitle, expectedNavigationTitle)
        }
        
        guard let url = URL(string: "url") else {
            XCTFail()
            return
        }
        _ = StoryBrowserPresenter(for: display, url: url)
    }
    
    func testPresenter_SetsRequest() {
        
        guard let url = URL(string: "url") else {
            XCTFail()
            return
        }
        
        let expectedRequest = URLRequest(url: url)
        display.request = expectedRequest
        display.requestHandler = { request in
            XCTAssertEqual(request?.url, expectedRequest.url)
        }
        
        _ = StoryBrowserPresenter(for: display, url: url)
    }
    
    func testPresenter_SetsDelegate() {

        let expectedDelegate = StoryBrowserWebViewDelegate()
        display.delegate = expectedDelegate
        
        display.delegateHandler = { delegate in
            XCTAssertTrue(delegate === expectedDelegate)
        }

        guard let url = URL(string: "url") else {
            XCTFail()
            return
        }
        _ = StoryBrowserPresenter(for: display, url: url)
    }

    func testPresenter_AddUIElements() {

        let expectedUIElementsAdded = true
        display.UIElementsAdded = expectedUIElementsAdded
        display.uiElementsAddedStartedHandler = { UIElementsAdded in
            XCTAssertTrue(UIElementsAdded ?? false)
        }

        guard let url = URL(string: "url") else {
            XCTFail()
            return
        }
        _ = StoryBrowserPresenter(for: display, url: url)
    }



}

// MARK: - Mocks

private extension StoryBrowserPresenterTests {
    
    class MockDisplay: StoryBrowserDisplay {
        
        var navigationTitle: String?
        var request: URLRequest?
        var delegate: StoryBrowserWebViewDelegate?
        var UIElementsAdded = false
        
        var navigationTitleHandler: ((String?) -> (Void))?
        var requestHandler: ((URLRequest?) -> (Void))?
        var delegateHandler: ((StoryBrowserWebViewDelegate?) -> (Void))?
        var uiElementsAddedStartedHandler: ((Bool?)  -> (Void))?
        
        func setNavigationTitle(_ title: String) {
            navigationTitleHandler?(self.navigationTitle)
        }
        
        func addUIElements() {
            uiElementsAddedStartedHandler?(self.UIElementsAdded)
        }
        
        func loadWebView(with request: URLRequest) {
            requestHandler?(self.request)
        }
        
        func setWebViewDelegate(_ delegate: StoryBrowserWebViewDelegate) {
            delegateHandler?(self.delegate)
        }
    }
}
