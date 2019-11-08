//
//	Result.swift
//  NYTopStoriesSimpleTutorial
//
//  Created by Ahmed Labib on 03.11.19.
//  Copyright © 2019 Ahmed Labib. All rights reserved.
//

import Foundation

struct TopStoriesResult: Equatable {
    
    let abstractField : String?
    let byline : String?
    let createdDate : String?
    let desFacet : [String]?
    let geoFacet : [String]?
    let itemType : String?
    let kicker : String?
    let materialTypeFacet : String?
    let multimedia : [TopStoriesMultimedia]?
    let orgFacet : [String]?
    let perFacet : [String]?
    let publishedDate : String?
    let section : String?
    let shortUrl : String?
    let subsection : String?
    let title : String?
    let updatedDate : String?
    let url : String?
}


extension TopStoriesResult: Codable {
    
    enum CodingKeys: String, CodingKey {
        case abstractField = "abstract"
        case byline = "byline"
        case createdDate = "created_date"
        case desFacet = "des_facet"
        case geoFacet = "geo_facet"
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
        abstractField = try values.decodeIfPresent(String.self, forKey: .abstractField)
        byline = try values.decodeIfPresent(String.self, forKey: .byline)
        createdDate = try values.decodeIfPresent(String.self, forKey: .createdDate)
        desFacet = try values.decodeIfPresent([String].self, forKey: .desFacet)
        geoFacet = try values.decodeIfPresent([String].self, forKey: .geoFacet)
        itemType = try values.decodeIfPresent(String.self, forKey: .itemType)
        kicker = try values.decodeIfPresent(String.self, forKey: .kicker)
        materialTypeFacet = try values.decodeIfPresent(String.self, forKey: .materialTypeFacet)
        multimedia = try values.decodeIfPresent([TopStoriesMultimedia].self, forKey: .multimedia)
        orgFacet = try values.decodeIfPresent([String].self, forKey: .orgFacet)
        perFacet = try values.decodeIfPresent([String].self, forKey: .perFacet)
        publishedDate = try values.decodeIfPresent(String.self, forKey: .publishedDate)
        section = try values.decodeIfPresent(String.self, forKey: .section)
        shortUrl = try values.decodeIfPresent(String.self, forKey: .shortUrl)
        subsection = try values.decodeIfPresent(String.self, forKey: .subsection)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        updatedDate = try values.decodeIfPresent(String.self, forKey: .updatedDate)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }
}
