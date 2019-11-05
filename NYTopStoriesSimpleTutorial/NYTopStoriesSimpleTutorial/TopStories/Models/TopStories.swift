//
//	TopStories.swift
//  NYTopStoriesSimpleTutorial
//
//  Created by Ahmed Labib on 03.11.19.
//  Copyright © 2019 Ahmed Labib. All rights reserved.
//

import Foundation

struct TopStories: Equatable {
    
    var copyright : String
    var lastUpdated : String
    var numResults : Int
    var results : [TopStoriesResult]
    var section : String
    var status : String
    
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
        copyright = try values.decode(String.self, forKey: .copyright)
        lastUpdated = try values.decode(String.self, forKey: .lastUpdated)
        numResults = try values.decode(Int.self, forKey: .numResults)
        results = try values.decode([TopStoriesResult].self, forKey: .results)
        section = try values.decode(String.self, forKey: .section)
        status = try values.decode(String.self, forKey: .status)
    }
}
