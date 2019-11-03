//
//  ViewController.swift
//  NYTopStoriesSimpleTutorial
//
//  Created by Ahmed Labib on 03.11.19.
//  Copyright © 2019 Ahmed Labib. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        fetch()
    }

    
    func fetch() {
        let serverManager = ServerManager()
        serverManager.getTopStories()
        serverManager.didFinish =
            { json in
                guard let obj = json as? TopStories else {
                  return
                }
                print(obj)
        }
        serverManager.didFinishWithError =
            { webserviceError, error in
                print("\n\n===========Error===========")
        }
        
    }

}

