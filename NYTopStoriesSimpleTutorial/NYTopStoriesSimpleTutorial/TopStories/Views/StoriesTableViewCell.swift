//
//  StoriesTableViewCell.swift
//  NYTopStoriesSimpleTutorial
//
//  Created by Ahmed Labib on 05.11.19.
//  Copyright © 2019 Ahmed Labib. All rights reserved.
//

import UIKit

class StoriesTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var storyImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var authorLabel: UILabel!
    
    private var diposable: Disposable?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 4
        containerView.layer.borderColor = UIColor.black.cgColor
        containerView.layer.borderWidth = 0.7
        self.storyImageView.layer.cornerRadius = 4
        Shadows.setupShadowFor(containerView)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        diposable?.dispose()
        self.storyImageView.image = Asset.placeholder.image
    }
    
    func configure(with story: TopStoriesResult) {
        titleLabel.text = story.title
        authorLabel.text = story.byline
        guard
            let urlString = story.multimedia.first(where: { $0.formatType == .standard })?.url,
            let imageURL = URL(string: urlString) else {
            return
        }
        diposable = ImageDownloader().downloadImageWith(url: imageURL, placeholder:Asset.placeholder.image, imageView: storyImageView)
    }
    
}
