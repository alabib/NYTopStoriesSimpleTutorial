//
//  TopStoriesDetailsPresenterTests.swift
//  NYTopStoriesSimpleTutorialTests
//
//  Created by Ahmed Labib on 07.11.19.
//  Copyright © 2019 Ahmed Labib. All rights reserved.
//

import XCTest
@testable import NYTopStoriesSimpleTutorial

class TopStoriesDetailsPresenterTests: XCTestCase {

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
        
        let story = createTopStoriesResultObjectWith()
        _ = TopStoriesDetailsPresenter(for: display, story: story)
    }
    
    func testPresenter_SetsTitle() {
        
        let expectedTitle = "title"
        display.title = expectedTitle
        display.titleHandler = { title in
            XCTAssertEqual(title, expectedTitle)
        }
        
        let story = createTopStoriesResultObjectWith()
        _ = TopStoriesDetailsPresenter(for: display, story: story)
    }
    
    func testPresenter_SetsURL() {
        
        let expectedURL = URL(string: "URL")
        display.url = expectedURL
        display.urlHandler = { url in
            XCTAssertEqual(url, expectedURL)
        }
        
        let story = createTopStoriesResultObjectWith()
        _ = TopStoriesDetailsPresenter(for: display, story: story)
    }
    
    func testPresenter_SetsAuthor() {
        
        let expectedAuthor = "Author"
        display.author = expectedAuthor
        display.authorHandler = { author in
            XCTAssertEqual(author, expectedAuthor)
        }
        
        let story = createTopStoriesResultObjectWith()
        _ = TopStoriesDetailsPresenter(for: display, story: story)
    }
    
    func testPresenter_SetsDescription() {
        
        let expectedDescription = "Description"
        display.description = expectedDescription
        display.descriptionHandler = { description in
            XCTAssertEqual(description, expectedDescription)
        }
        
        let story = createTopStoriesResultObjectWith()
        _ = TopStoriesDetailsPresenter(for: display, story: story)
    }


}

// MARK: - Mocks

private extension TopStoriesDetailsPresenterTests {
    
    class MockDisplay: TopStoriesDetailsDisplay {
        
        var navigationTitle: String?
        var title: String?
        var url: URL?
        var author: String?
        var description: String?
        
        var navigationTitleHandler: ((String?) -> (Void))?
        var titleHandler: ((String?) -> (Void))?
        var urlHandler: ((URL?) -> (Void))?
        var authorHandler: ((String?) -> (Void))?
        var descriptionHandler: ((String?) -> (Void))?
        
        func setNavigationTitle(_ title: String) {
            navigationTitleHandler?(self.navigationTitle)
        }
        
        func setTitleLabel(with title: String) {
            titleHandler?(self.title)
        }
        
        func setImage(with url: URL) {
            urlHandler?(self.url)
        }
        
        func setAuthorLabel(with author: String) {
            authorHandler?(self.author)
        }
        
        func setDescriptionLabel(with description: String) {
            descriptionHandler?(self.description)
        }
    }
}


// MARK: - Helper Mthods

extension TopStoriesDetailsPresenterTests {
    
    private func createTopStoriesResultObjectWith(section: String = "section",
                                                  byline: String = "byline",
                                                  url: String = "url",
                                                  title: String = "title") -> TopStoriesResult {
        return TopStoriesResult(abstractField: "abstractField",
                                byline: byline,
                                createdDate: "createdDate",
                                desFacet: ["desFacet"],
                                geoFacet: ["geoFacet"],
                                itemType: "itemType",
                                kicker: "kicker",
                                materialTypeFacet: "materialTypeFacet",
                                multimedia: [TopStoriesMultimedia(caption: "caption",
                                                                  copyright: "copyright",
                                                                  format: "format",
                                                                  formatType: .standard,
                                                                  height: 1,
                                                                  subtype: "subtype",
                                                                  type: "type",
                                                                  url: url,
                                                                  width: 1)],
                                orgFacet: ["orgFacet"],
                                perFacet: ["perFacet"],
                                publishedDate: "publishedDate",
                                section: "section",
                                shortUrl: section,
                                subsection: "subsection",
                                title: title,
                                updatedDate: "updatedDate",
                                url: "url")
    }
    
}
