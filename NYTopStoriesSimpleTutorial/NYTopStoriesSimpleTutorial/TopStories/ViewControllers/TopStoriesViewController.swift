//
//  ViewController.swift
//  NYTopStoriesSimpleTutorial
//
//  Created by Ahmed Labib on 03.11.19.
//  Copyright © 2019 Ahmed Labib. All rights reserved.
//

import UIKit

class TopStoriesViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    private var presenter: TopStoriesPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.nyRegisterNib(cellType: StoriesTableViewCell.self)
        self.presenter = TopStoriesPresenter(for: self)
    }

}

extension TopStoriesViewController: TopStoriesDisplay {
    func setTableDelegateAndDatasource(with listDataProvider: TopStoriesListDataProvider) {
        tableView.delegate = listDataProvider
        tableView.dataSource = listDataProvider
        tableView.reloadData()
    }
    
}

