//
//  Assets.swift
//  NYTopStoriesSimpleTutorial
//
//  Created by Ahmed Labib on 06.11.19.
//  Copyright © 2019 Ahmed Labib. All rights reserved.
//

import UIKit.UIImage

public enum Asset {
    public static let placeholder = ImageAsset(name: "placeholder")
}

public struct ImageAsset {
    public fileprivate(set) var name: String

    public var image: UIImage {
        
        let bundle = Bundle(for: BundleToken.self)
        let image = UIImage(named: name, in: bundle, compatibleWith: nil)
        guard let result = image else {
            fatalError("Unable to load image named \(name).")
        }
        return result
    }
}

private final class BundleToken {}
