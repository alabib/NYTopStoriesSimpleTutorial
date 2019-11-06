//
//  TopStoriesDetailsViewController.swift
//  NYTopStoriesSimpleTutorial
//
//  Created by Ahmed Labib on 06.11.19.
//  Copyright © 2019 Ahmed Labib. All rights reserved.
//

import UIKit


class TopStoriesDetailsViewController: UIViewController {
    
    @IBOutlet private weak var storyImageView: UIImageView!
    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var storyTitleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var seeMoreContainerView: UIView!
    @IBOutlet private weak var seeMoreButton: UIButton!
    @IBOutlet weak var imageviewHeightConstraint: NSLayoutConstraint!
    
    var story: TopStoriesResult?
    
    private var presenter: TopStoriesDetailsPresenter?
    private var diposable: Disposable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter = TopStoriesDetailsPresenter(for: self, story: story)
        
    }
    
    private func setupUI() {
        seeMoreButton.layer.cornerRadius = 8
        Shadows.setupShadowFor(seeMoreContainerView)
        Shadows.setupShadowFor(seeMoreButton)
    }
    
    
}

extension TopStoriesDetailsViewController: TopStoriesDetailsDisplay {
    
    func setNavigationTitle(_ title: String) {
        self.title = title
    }
    
    func setTitleLabel(with title: String) {
        storyTitleLabel.text = title
    }
    
    func setImage(with url: URL) {
        _ = ImageDownloader().downloadImageWith(url: url, placeholder: UIImage(named: "placeholder"), imageView: storyImageView, completion: { [unowned self] image, _ in
            
            guard let image = image else {
                return
            }
            DispatchQueue.main.async {
                let imageViewHeight = (self.storyImageView.frame.size.width * image.size.height) / image.size.width
                self.imageviewHeightConstraint.constant = imageViewHeight
            }
            
        })
    }
    
    func setAuthorLabel(with author: String) {
        authorLabel.text = author
    }
    
    func setDescriptionLabel(with description: String) {
        descriptionLabel.text = description
    }

}
