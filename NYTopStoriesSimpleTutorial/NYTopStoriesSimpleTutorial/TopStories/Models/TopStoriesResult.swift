//
//	Result.swift
//  NYTopStoriesSimpleTutorial
//
//  Created by Ahmed Labib on 03.11.19.
//  Copyright © 2019 Ahmed Labib. All rights reserved.
//

import Foundation

struct TopStoriesResult {
    
    var abstractField : String
    var byline : String
    var createdDate : String
    var desFacet : [String]
    var itemType : String
    var kicker : String
    var materialTypeFacet : String
    var multimedia : [TopStoriesMultimedia]
    var orgFacet : [String]
    var perFacet : [String]
    var publishedDate : String
    var section : String
    var shortUrl : String
    var subsection : String
    var title : String
    var updatedDate : String
    var url : String
}


extension TopStoriesResult: Codable {
    
    enum CodingKeys: String, CodingKey {
        case abstractField = "abstract"
        case byline = "byline"
        case createdDate = "created_date"
        case desFacet = "des_facet"
        case itemType = "item_type"
        case kicker = "kicker"
        case materialTypeFacet = "material_type_facet"
        case multimedia = "multimedia"
        case orgFacet = "org_facet"
        case perFacet = "per_facet"
        case publishedDate = "published_date"
        case section = "section"
        case shortUrl = "short_url"
        case subsection = "subsection"
        case title = "title"
        case updatedDate = "updated_date"
        case url = "url"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        abstractField = try values.decode(String.self, forKey: .abstractField)
        byline = try values.decode(String.self, forKey: .byline)
        createdDate = try values.decode(String.self, forKey: .createdDate)
        desFacet = try values.decode([String].self, forKey: .desFacet)
        itemType = try values.decode(String.self, forKey: .itemType)
        kicker = try values.decode(String.self, forKey: .kicker)
        materialTypeFacet = try values.decode(String.self, forKey: .materialTypeFacet)
        multimedia = try values.decode([TopStoriesMultimedia].self, forKey: .multimedia)
        orgFacet = try values.decode([String].self, forKey: .orgFacet)
        perFacet = try values.decode([String].self, forKey: .perFacet)
        publishedDate = try values.decode(String.self, forKey: .publishedDate)
        section = try values.decode(String.self, forKey: .section)
        shortUrl = try values.decode(String.self, forKey: .shortUrl)
        subsection = try values.decode(String.self, forKey: .subsection)
        title = try values.decode(String.self, forKey: .title)
        updatedDate = try values.decode(String.self, forKey: .updatedDate)
        url = try values.decode(String.self, forKey: .url)
    }
}
