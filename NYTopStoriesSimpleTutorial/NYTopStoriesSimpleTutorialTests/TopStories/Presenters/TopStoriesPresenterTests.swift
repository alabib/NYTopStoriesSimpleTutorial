//
//  TopStoriesPresenterTests.swift
//  NYTopStoriesSimpleTutorialTests
//
//  Created by Ahmed Labib on 07.11.19.
//  Copyright © 2019 Ahmed Labib. All rights reserved.
//

import XCTest
@testable import NYTopStoriesSimpleTutorial

class TopStoriesPresenterTests: XCTestCase {
    
    private var subject: TopStoriesPresenter?
    private var display: MockDisplay!
    private var serverManager: ServerManageable!
    private var cellfactory: MockCellFactory!
    
    override func setUp() {
    
        super.setUp()
        display = MockDisplay()
        let jsonData = jsonString().data(using: .utf8)
        serverManager = MockServerManager(session: MockURLSession(data: jsonData, urlResponse: nil, error: nil))
        cellfactory = MockCellFactory()
    }
    
    override func tearDown() {
        subject = nil
        display = nil
        serverManager = nil
        cellfactory = nil
    }
    
    
    func testPresenter_SetsNavigationTitle() {
        
       let expectedNavigationTitle = "navigationTitle"
        display.navigationTitle = expectedNavigationTitle
        display.navigationTitleHandler = { navigationTitle in
            XCTAssertEqual(navigationTitle, expectedNavigationTitle)
        }
        
        
        subject = TopStoriesPresenter(for: display,
                                          serverManager: serverManager,
                                          descriptor: TopStoriesDescriptor(),
                                          cellModelsFactory: cellfactory)
    }
    
    func testPresenter_SetsStory() {
        
        let expectedStory = createTopStoriesResultObjectWith()
        
        display.story = expectedStory
        display.storyHandler = { story in
            XCTAssertEqual(story, expectedStory)
        }
        
        
        subject = TopStoriesPresenter(for: display,
                                serverManager: serverManager,
                                descriptor: TopStoriesDescriptor(),
                                cellModelsFactory: cellfactory)
    }
    
    func testPresenter_SetsListDataProvider() {
        
        let expectedListDataProvider = TopStoriesListDataProvider(storyCellModels: [StoryCellModel(title: "title",
                                                                                                   byline: "byline",
                                                                                                   thumbnailURL: URL(string: "url"))])
        
        display.listDataProvider = expectedListDataProvider
        
        let setlistDataProviderExpectation = expectation(description: "listDataProviderHandler is not set")
        display.listDataProviderHandler = { listDataProvider in
            XCTAssertTrue(listDataProvider === expectedListDataProvider)
            setlistDataProviderExpectation.fulfill()
        }
        
        let storyCellModels = [StoryCellModel(title: "title",
                                                      byline: "byline",
                                                      thumbnailURL: URL(string: "url"))]
        
        cellfactory.storyCellModels = storyCellModels
        subject = TopStoriesPresenter(for: display,
                                serverManager: serverManager,
                                descriptor: TopStoriesDescriptor(),
                                cellModelsFactory: cellfactory)
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testPresenter_StartsLoader() {
        
        let expectedloaderStarted = true
        
        display.loaderStarted = expectedloaderStarted
        display.loaderStartedHandler = { loaderStarted in
            XCTAssertEqual(loaderStarted, expectedloaderStarted)
        }
        
        
        subject = TopStoriesPresenter(for: display,
                                serverManager: serverManager,
                                descriptor: TopStoriesDescriptor(),
                                cellModelsFactory: cellfactory)
    }
    
    func testPresenter_StopssLoader() {
        
        let expectedloaderStoped = true
        
        display.loaderStoped = expectedloaderStoped
        display.loaderStopedHandler = { loaderStoped in
            XCTAssertEqual(loaderStoped, expectedloaderStoped)
        }
        
        
        subject = TopStoriesPresenter(for: display,
                                serverManager: serverManager,
                                descriptor: TopStoriesDescriptor(),
                                cellModelsFactory: cellfactory)
    }
    
    func testPresenter_SetsCellModel() {
        
        let expectedTitle = "title"
        let expectedByline = "byline"
        let expectedURL = "url"
        
        let expectedStoryCellModels = [StoryCellModel(title: expectedTitle,
                                              byline: expectedByline,
                                              thumbnailURL: URL(string: expectedURL))]
        
        cellfactory.storyCellModels = expectedStoryCellModels
        
        let dataManager = MockDataManager()
        let story = createTopStoriesResultObjectWith(byline: expectedByline, url: expectedURL, title: expectedTitle)
        dataManager.stories = [story]
        let actualStoryCellModels = cellfactory.buildStoryCellModels(with: dataManager)
        
        
        subject = TopStoriesPresenter(for: display,
                                serverManager: serverManager,
                                descriptor: TopStoriesDescriptor(),
                                cellModelsFactory: cellfactory)
        
        XCTAssertEqual(actualStoryCellModels, expectedStoryCellModels)
    }

}

// MARK: - Mocks
private extension TopStoriesPresenterTests {
    
    class MockServerManager: ServerManageable {
        
        private var session: SessionProtocol
        
        init(session: SessionProtocol) {
            self.session = session
        }
        
        var didFinish: TopStoriesPresenterTests.MockServerManager.DidFinishDelegate?
        
        var didFinishWithError: TopStoriesPresenterTests.MockServerManager.DidFinishWithErrorDelegate?
        
        func httpConnect<A>(resource: Resource<A>, completion: @escaping (Any?) -> (), errorHandler: @escaping (WebserviceError, Any?) -> ()) {
            
            guard let url = URL(string: "URL") else {
                return
            }
            
            session.dataTask(with: url) { (data, response, error) in
                
                guard error == nil else {
                    errorHandler(.responseError, error)
                    return
                    
                }
                guard let data = data else {
                    errorHandler(.dataEmptyError, nil)
                    return
                }
                
                let result = resource.parse(data)
                
                DispatchQueue.main.async {
                    completion(result)
                }
                
                }.resume()
        }
        
        
        func getTopStories()
        {
            httpConnect(resource: TopStories.resourceForTopStories(), completion:
                { (json) in
                    guard let jsonObject = json else {
                        self.didFinishWithError?(.dataEmptyError, nil)
                        return
                    }
                    self.didFinish?(jsonObject as AnyObject?)
            })
            { (error, msg) in
                self.didFinishWithError?(error, msg)
            }
        }
        
    }
    
    class MockURLSession: SessionProtocol {
        
        
        var url: URL?
        private let dataTask: MockTask
        
        init(data: Data?, urlResponse: URLResponse?, error: Error?) {
            dataTask = MockTask(data: data,
                                urlResponse: urlResponse,
                                error: error)
        }
        
        func dataTask(
            with url: URL,
            completionHandler: @escaping
            (Data?, URLResponse?, Error?) -> Void)
            -> URLSessionDataTask {
                
                
                self.url = url
                print(url)
                dataTask.completionHandler = completionHandler
                return dataTask
        }
    }
    
    class MockTask: URLSessionDataTask {
        private let data: Data?
        private let urlResponse: URLResponse?
        private let responseError: Error?
        
        typealias CompletionHandler = (Data?, URLResponse?, Error?)
            -> Void
        var completionHandler: CompletionHandler?
        
        
        init(data: Data?, urlResponse: URLResponse?, error: Error?) {
            self.data = data
            self.urlResponse = urlResponse
            self.responseError = error
        }
        
        
        override func resume() {
            DispatchQueue.main.async() {
                self.completionHandler?(self.data,
                                        self.urlResponse,
                                        self.responseError)
            }
        }
    }
    
    class MockDisplay: TopStoriesDisplay {
        
        var navigationTitle: String?
        var story: TopStoriesResult?
        var listDataProvider: TopStoriesListDataProvider?
        var loaderStarted: Bool?
        var loaderStoped: Bool?
        
        
        var navigationTitleHandler: ((String?) -> (Void))?
        var storyHandler: ((TopStoriesResult?) -> (Void))?
        var listDataProviderHandler: ((TopStoriesListDataProvider?) -> (Void))?
        var loaderStartedHandler: ((Bool?)  -> (Void))?
        var loaderStopedHandler: ((Bool?) -> (Void))?
        
        func setNavigationTitle(_ title: String) {
            navigationTitleHandler?(navigationTitle)
        }
        
        func setTableDelegateAndDatasource(with listDataProvider: TopStoriesListDataProvider) {
            listDataProviderHandler?(self.listDataProvider)
        }
        
        func navigateToDetails(with story: TopStoriesResult) {
            storyHandler?(story)
        }
        
        func startLoader() {
            loaderStartedHandler?(loaderStarted)
        }
        
        func stopLoader() {
            loaderStopedHandler?(loaderStoped)
        }
    }
    
    class MockCellFactory: StoryCellModelsBuilder {
        
        var storyCellModels: [StoryCellModel]?
        
        func buildStoryCellModels(with dataManager: TopStoriesDataManageable) -> [StoryCellModel]? {
            return storyCellModels
        }
    }
    
    class MockDataManager: TopStoriesDataManageable {
        
        var stories: [TopStoriesResult]?
        
        var storiesCount: Int {
            return stories?.count ?? 0
        }
        
        func add(_ story: TopStoriesResult?) {
            
        }
        
        func story(at index: Int) -> TopStoriesResult? {
            return stories?[index]
        }
        
        
    }
}

// MARK: - Helper Mthods

extension TopStoriesPresenterTests {
    
    private func createTopStoriesResultObjectWith(byline: String = "byline",
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
                                shortUrl: "section",
                                subsection: "subsection",
                                title: title,
                                updatedDate: "updatedDate",
                                url: "url")
    }
    
    private func jsonString() -> String {
        return """
        {
        \"status\": \"OK\",
        \"copyright\": \"Copyright (c) 2019 The New York Times Company. All Rights Reserved.\",
        \"section\": \"home\",
        \"last_updated\": \"2019-11-07T16:17:18-05:00\",
        \"num_results\": 32,
        \"results\": [
        {
        \"section\": \"Business\",
        \"subsection\": \"\",
        \"title\": \"U.S. and China Agree to Roll Back Some Tariffs if Deal is Struck\",
        \"abstract\": \"The development suggests progress toward an interim agreement that would provide relief to businesses and consumers.\",
        \"url\": \"https://www.nytimes.com/2019/11/07/business/china-trade-trump.html\",
        \"byline\": \"By ANA SWANSON and KEITH BRADSHER\",
        \"item_type\": \"Article\",
        \"updated_date\": \"2019-11-07T13:57:41-05:00\",
        \"created_date\": \"2019-11-07T05:57:55-05:00\",
        \"published_date\": \"2019-11-07T05:57:55-05:00\",
        \"material_type_facet\": \"\",
        \"kicker\": \"\",
        \"des_facet\": [
        \"International Trade and World Market\",
        \"Politics and Government\",
        \"Customs (Tariff)\"
        ],
        \"org_facet\": [
        \"Communist Party of China\"
        ],
        \"per_facet\": [],
        \"geo_facet\": [
        \"China\"
        ],
        \"multimedia\": [
        {
        \"url\": \"https://static01.nyt.com/images/2019/11/07/business/07china-trade-promo/merlin_155582940_b394305d-6d7e-4914-a571-d9377d038d67-thumbStandard.jpg\",
        \"format\": \"Standard Thumbnail\",
        \"height\": 75,
        \"width\": 75,
        \"type\": \"image\",
        \"subtype\": \"photo\",
        \"caption\": \"A container ship docked at a port in&nbsp;Shanghai\",
        \"copyright\": \"Lam Yik Fei for The New York Times\"
        }
        ],
        \"short_url\": \"https://nyti.ms/2K1bocW\"
        }
        ]
        }
        """
    }
}
