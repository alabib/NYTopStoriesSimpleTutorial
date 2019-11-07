//
//  TopStoriesPresenterTests.swift
//  NYTopStoriesSimpleTutorialTests
//
//  Created by Ahmed Labib on 07.11.19.
//  Copyright © 2019 Ahmed Labib. All rights reserved.
//

import XCTest
@testable import NYTopStoriesSimpleTutorial

//TODO: Add testing cases to the rest of the class but this a sample of testing because I had business trip this week so I couldn't finish the rest of the testiong

class TopStoriesPresenterTests: XCTestCase {
    
    var display: MockDisplay!
    var serverManager: ServerManager!
    var cellfactory: MockCellFactory!
    
    override func setUp() {
        super.setUp()
        display = MockDisplay()
        let error = NSError(domain: "SomeError",
                            code: 1234,
                            userInfo: nil)
        let jsonData = jsonString().data(using: .utf8)
        serverManager = ServerManager(session: MockURLSession(data: jsonData, urlResponse: nil, error: error))
        cellfactory = MockCellFactory()
    }
    
    
    func testPresenter_SetsNavigationTitle() {
        
       let expectedNavigationTitle = "navigationTitle"
        display.navigationTitle = expectedNavigationTitle
        display.navigationTitleHandler = { navigationTitle in
            XCTAssertEqual(navigationTitle, expectedNavigationTitle)
        }
        
        
        _ = TopStoriesPresenter(for: display,
                                          serverManager: serverManager,
                                          descriptor: TopStoriesDescriptor(),
                                          cellModelsFactory: cellfactory)
    }
    
    func testPresenter_SetsStory() {
        
        let expectedStory = TopStoriesResult(abstractField: "abstractField",
                                             byline: "byline",
                                             createdDate: "createdDate",
                                             desFacet: ["desFacet"],
                                             itemType: "itemType",
                                             kicker: "kicker",
                                             materialTypeFacet: "materialTypeFacet",
                                             multimedia: [TopStoriesMultimedia(caption: "caption",
                                                                               copyright: "copyright",
                                                                               format: "format",
                                                                               formatType: .normal,
                                                                               height: 1,
                                                                               subtype: "subtype",
                                                                               type: "type",
                                                                               url: "url",
                                                                               width: 1)],
                                             orgFacet: ["orgFacet"],
                                             perFacet: ["perFacet"],
                                             publishedDate: "publishedDate",
                                             section: "section",
                                             shortUrl: "section",
                                             subsection: "subsection",
                                             title: "title",
                                             updatedDate: "updatedDate",
                                             url: "url")
        
        display.story = expectedStory
        display.storyHandler = { story in
            XCTAssertEqual(story, expectedStory)
        }
        
        
        _ = TopStoriesPresenter(for: display,
                                serverManager: serverManager,
                                descriptor: TopStoriesDescriptor(),
                                cellModelsFactory: cellfactory)
    }
    
    func testPresenter_SetsListDataProvider() {
        
        let expectedListDataProvider = TopStoriesListDataProvider(storyCellModels: [StoryCellModel(title: "title",
                                                                                                   byline: "byline",
                                                                                                   thumbnailURL: URL(string: "url"))])
        
        display.listDataProvider = expectedListDataProvider
        display.listDataProviderHandler = { listDataProvider in
            XCTAssertEqual(listDataProvider, expectedListDataProvider)
        }
        
        
        _ = TopStoriesPresenter(for: display,
                                serverManager: serverManager,
                                descriptor: TopStoriesDescriptor(),
                                cellModelsFactory: cellfactory)
    }
    
    func testPresenter_StartsLoader() {
        
        let expectedloaderStarted = true
        
        display.loaderStarted = expectedloaderStarted
        display.loaderStartedHandler = { loaderStarted in
            XCTAssertEqual(loaderStarted, expectedloaderStarted)
        }
        
        
        _ = TopStoriesPresenter(for: display,
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
        
        
        _ = TopStoriesPresenter(for: display,
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
        dataManager.stories = [TopStoriesResult(abstractField: "abstractField",
                                                byline: expectedByline,
                                                createdDate: "createdDate",
                                                desFacet: ["desFacet"],
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
                                                                                  url: expectedURL,
                                                                                  width: 1)],
                                                orgFacet: ["orgFacet"],
                                                perFacet: ["perFacet"],
                                                publishedDate: "publishedDate",
                                                section: "section",
                                                shortUrl: "section",
                                                subsection: "subsection",
                                                title: expectedTitle,
                                                updatedDate: "updatedDate",
                                                url: "url")]
        let actualStoryCellModels = cellfactory.buildStoryCellModels(with: dataManager)
        
        
        _ = TopStoriesPresenter(for: display,
                                serverManager: serverManager,
                                descriptor: TopStoriesDescriptor(),
                                cellModelsFactory: cellfactory)
        
        XCTAssertEqual(actualStoryCellModels, expectedStoryCellModels)
    }

}

// MARK: - Mocks
extension TopStoriesPresenterTests {
    
    class MockURLSession: SessionProtocol {
        
        
        var url: URL?
        private let dataTask: MockTask
        
        var urlComponents: URLComponents? {
            guard let url = url else { return nil }
            return URLComponents(url: url,
                                 resolvingAgainstBaseURL: true)
        }
        
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
            listDataProviderHandler?(listDataProvider)
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
        
        func add(_ story: TopStoriesResult) {
            
        }
        
        func story(at index: Int) -> TopStoriesResult? {
            return stories?[index]
        }
        
        
    }
}

extension TopStoriesPresenterTests {
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
