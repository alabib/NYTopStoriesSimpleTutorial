//
//  ImageDownloader.swift
//  NYTopStoriesSimpleTutorial
//
//  Created by Ahmed Labib on 05.11.19.
//  Copyright © 2019 Ahmed Labib. All rights reserved.
//

import UIKit

public protocol Disposable {
    func dispose()
}

extension URLSessionDataTask: Disposable {
    public func dispose() {
        self.cancel()
    }
}

public class ImageDownloader {
    func downloadImageWith(url: URL, placeholder: UIImage?, imageView: UIImageView) -> Disposable {
        imageView.image = placeholder
        let dataTask = URLSession.shared.dataTask(with: url) { (data, respnse, error) in
            if
                let data = data,
                let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    imageView.image = image
                }
            }
        }
        dataTask.resume()
        return dataTask
    }
}
