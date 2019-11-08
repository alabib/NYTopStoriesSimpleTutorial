//
//	Multimedia.swift
//  NYTopStoriesSimpleTutorial
//
//  Created by Ahmed Labib on 03.11.19.
//  Copyright © 2019 Ahmed Labib. All rights reserved.
//

import Foundation

struct TopStoriesMultimedia: Equatable {
    
    enum ImageFormatType: String {
        case standard = "Standard Thumbnail"
        case thumbLarge = "thumbLarge"
        case normal = "Normal"
        case medium = "mediumThreeByTwo210"
        case superJumbo = "superJumbo"
        case none
        
        static func formateType(_ string: String?) -> ImageFormatType {
            guard let formatString = string else {
                return .none
            }
            return ImageFormatType(rawValue: formatString) ?? .none
        }
    }
    
    let caption : String?
    let copyright : String?
    let format : String?
    var formatType : ImageFormatType
    let height : Int?
    let subtype : String?
    let type : String?
    let url : String?
    let width : Int?

}

extension TopStoriesMultimedia: Codable {
    
    enum CodingKeys: String, CodingKey {
        case caption = "caption"
        case copyright = "copyright"
        case format = "format"
        case height = "height"
        case subtype = "subtype"
        case type = "type"
        case url = "url"
        case width = "width"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        caption = try values.decodeIfPresent(String.self, forKey: .caption)
        copyright = try values.decodeIfPresent(String.self, forKey: .copyright)
        format = try values.decodeIfPresent(String.self, forKey: .format)
        height = try values.decodeIfPresent(Int.self, forKey: .height)
        subtype = try values.decodeIfPresent(String.self, forKey: .subtype)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        width = try values.decodeIfPresent(Int.self, forKey: .width)
        formatType = ImageFormatType.formateType(format)
    }
}
