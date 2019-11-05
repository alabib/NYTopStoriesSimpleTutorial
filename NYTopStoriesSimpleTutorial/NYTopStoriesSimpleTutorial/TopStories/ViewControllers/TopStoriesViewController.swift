//
//  ViewController.swift
//  NYTopStoriesSimpleTutorial
//
//  Created by Ahmed Labib on 03.11.19.
//  Copyright © 2019 Ahmed Labib. All rights reserved.
//

import UIKit

class TopStoriesViewController: UIViewController {

    private var presenter: TopStoriesPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = TopStoriesPresenter(for: self)
    }

}

extension TopStoriesViewController: TopStoriesDisplay {
    func get(manager: TopStoriesDataManageable) {
        print(manager.storiesCount)
    }
    
    
}

