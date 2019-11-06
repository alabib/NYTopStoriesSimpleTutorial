//
//  ImageDownloader.swift
//  NYTopStoriesSimpleTutorial
//
//  Created by Ahmed Labib on 05.11.19.
//  Copyright © 2019 Ahmed Labib. All rights reserved.
//

import UIKit

typealias DownloadImageCompletion = ((UIImage?, Bool) -> Void)

public protocol Disposable {
    func dispose()
}

extension URLSessionDataTask: Disposable {
    public func dispose() {
        self.cancel()
    }
}

public class ImageDownloader {
    func downloadImageWith(url: URL, placeholder: UIImage?, imageView: UIImageView, completion: DownloadImageCompletion? = nil) -> Disposable {
        imageView.image = placeholder
        let dataTask = URLSession.shared.dataTask(with: url) { (data, respnse, error) in
            if
                let data = data,
                let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    imageView.image = image
                }
                completion?(image, true)
            }
            completion?(nil, false)
        }
        dataTask.resume()
        return dataTask
    }
}
