//
//	TopStories.swift
//  NYTopStoriesSimpleTutorial
//
//  Created by Ahmed Labib on 03.11.19.
//  Copyright © 2019 Ahmed Labib. All rights reserved.
//

import Foundation

struct TopStories: Equatable {
    
    let copyright : String?
    let lastUpdated : String?
    let numResults : Int?
    let results : [TopStoriesResult]?
    let section : String?
    let status : String?
    
}


extension TopStories: Codable {
    
    enum CodingKeys: String, CodingKey {
        case copyright = "copyright"
        case lastUpdated = "last_updated"
        case numResults = "num_results"
        case results = "results"
        case section = "section"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        copyright = try values.decodeIfPresent(String.self, forKey: .copyright)
        lastUpdated = try values.decodeIfPresent(String.self, forKey: .lastUpdated)
        numResults = try values.decodeIfPresent(Int.self, forKey: .numResults)
        results = try values.decodeIfPresent([TopStoriesResult].self, forKey: .results)
        section = try values.decodeIfPresent(String.self, forKey: .section)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}
