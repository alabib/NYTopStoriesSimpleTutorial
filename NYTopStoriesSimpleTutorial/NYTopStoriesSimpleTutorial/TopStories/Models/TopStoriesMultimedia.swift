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
        
        static func formateType(_ string: String) -> ImageFormatType {
            return ImageFormatType(rawValue: string) ?? .none
        }
    }
    
    var caption : String
    var copyright : String
    var format : String
    var formatType : ImageFormatType
    var height : Int
    var subtype : String
    var type : String
    var url : String
    var width : Int

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
        caption = try values.decode(String.self, forKey: .caption)
        copyright = try values.decode(String.self, forKey: .copyright)
        format = try values.decode(String.self, forKey: .format)
        height = try values.decode(Int.self, forKey: .height)
        subtype = try values.decode(String.self, forKey: .subtype)
        type = try values.decode(String.self, forKey: .type)
        url = try values.decode(String.self, forKey: .url)
        width = try values.decode(Int.self, forKey: .width)
        formatType = ImageFormatType.formateType(format)
    }
}
