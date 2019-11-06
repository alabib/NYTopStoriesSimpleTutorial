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
    
    private var presenter: TopStoriesPresenter?
    
    private let loadingIndicator = LoadingIndicator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.nyRegisterNib(cellType: StoriesTableViewCell.self)
        setupUI()
        presenter = TopStoriesPresenter(for: self)
    }
    
    private func setupUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        guard let navigationBar = navigationController?.navigationBar else { return }
        Shadows.setupShadowFor(navigationBar)
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
    
    func startLoader() {
        loadingIndicator.showLoading(onView: self.view)
    }
    
    func stopLoader() {
        loadingIndicator.removeLoading()
    }
    
    
    func setNavigationTitle(_ title: String) {
        self.title = title
    }
    
    func setTableDelegateAndDatasource(with listDataProvider: TopStoriesListDataProvider) {
        tableView.delegate = listDataProvider
        tableView.dataSource = listDataProvider
        animateTable()
    }
    
    func navigateToDetails(with story: TopStoriesResult) {
        let detailsViewController = UIStoryboard.makeViewController(ofType: TopStoriesDetailsViewController.self, storyBoardName: Constants.StoryboardNames.main)
        detailsViewController.story = story
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
}

