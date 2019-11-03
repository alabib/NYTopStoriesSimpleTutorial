//
//  Constants.swift
//  NYTopStoriesSimpleTutorial
//
//  Created by Labib, Ahmed (148) on 03.11.19.
//  Copyright © 2019 Labib, Ahmed. All rights reserved.
//

import Foundation

enum Constants {
    
    enum URLS {
        private static let BASE_URL = "https://api.nytimes.com/svc/topstories/v2/"
        static let homeTopStories = "\(BASE_URL)home.json"
    }
    
    enum APIKey {
        static let name = "api-key"
        static let value = "uJTj6sJKqo0KVHZ9ctcYcxUIumM1XVZ8"
    }
}
