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
        
        setupUI()
    }
    
    private func setupUI() {
        containerView.layer.cornerRadius = 4
        containerView.layer.borderColor = UIColor.black.cgColor
        containerView.layer.borderWidth = 0.7
        storyImageView.layer.cornerRadius = 4
        Shadows.setupShadowFor(containerView)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        diposable?.dispose()
        storyImageView.image = Asset.placeholder.image
    }
    
    func configure(with cellModel: StoryCellModel) {
        titleLabel.text = cellModel.title
        authorLabel.text = cellModel.byline
        guard let imageURL = cellModel.thumbnailURL else {
            return
        }
        
        diposable = ImageDownloader().downloadImageWith(url: imageURL, placeholder:Asset.placeholder.image, imageView: storyImageView)
    }
    
}
