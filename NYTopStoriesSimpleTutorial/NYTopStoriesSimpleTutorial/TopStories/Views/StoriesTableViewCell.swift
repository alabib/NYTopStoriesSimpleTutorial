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
        self.storyImageView.layer.cornerRadius = 4
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        diposable?.dispose()
        self.storyImageView.image = UIImage(named: "placeholder")
    }
    
    func configure(with story: TopStoriesResult) {
        titleLabel.text = story.title
        authorLabel.text = story.byline
        guard
            let urlString = story.multimedia.first(where: {$0.format == ImageFormat.standard.rawValue})?.url,
            let imageURL = URL(string: urlString) else {
            return
        }
        diposable = ImageDownloader().downloadImageWith(url: imageURL, placeholder: UIImage(named: "placeholder"), imageView: storyImageView)
    }
    
}

enum ImageFormat: String {
    case standard = "Standard Thumbnail"
    case thumbLarge = "thumbLarge"
    case normal = "Normal"
    case medium = "mediumThreeByTwo210"
    case superJumbo = "superJumbo"
}
