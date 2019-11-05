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
    
    // MARK: - Cells Animation Method
    
    private func animateTable()
    {
        tableView.reloadData()
        let cells = tableView.visibleCells
        
        let tableHeight: CGFloat = tableView.bounds.size.height
        
        for i in cells {
            let cell: UITableViewCell = i
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
        }
        
        var index = 0
        
        for a in cells {
            let cell: UITableViewCell = a
            UIView.animate(withDuration: 1.0, delay: 0.10 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0);
            }, completion: nil)
            
            index += 1
        }
    }

}

extension TopStoriesViewController: TopStoriesDisplay {
    func setTableDelegateAndDatasource(with listDataProvider: TopStoriesListDataProvider) {
        tableView.delegate = listDataProvider
        tableView.dataSource = listDataProvider
        animateTable()
    }
    
}

