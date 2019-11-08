//
//  ServerManagerCalls.swift
//  NYTopStoriesSimpleTutorial
//
//  Created by Ahmed Labib on 03.11.19.
//  Copyright © 2019 Ahmed Labib. All rights reserved.
//

import Foundation


extension ServerManager
{
    
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
