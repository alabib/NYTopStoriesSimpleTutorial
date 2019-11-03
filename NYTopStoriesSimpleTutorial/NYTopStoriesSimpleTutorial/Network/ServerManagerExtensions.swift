//
//  ServerManagerExtensions.swift
//  NYTopStoriesSimpleTutorial
//
//  Created by Ahmed Labib on 03.11.19.
//  Copyright © 2019 Ahmed Labib. All rights reserved.
//

import Foundation

extension TopStories
{
    private static var all = Resource<TopStories>(url: Constants.URLS.homeTopStories)
    { (data) -> TopStories? in
        
        guard
            let jsonData = data as? Data,
            let topStories = try? JSONDecoder().decode(TopStories.self, from: jsonData) else {
                return nil
        }
        
        return topStories
    }
    
    static func resourceForTopStories() -> Resource<TopStories>
    {
        return TopStories.all
    }
    
}
