//
//  LoadingIndicator.swift
//  NYTopStoriesSimpleTutorial
//
//  Created by Ahmed Labib on 06.11.19.
//  Copyright © 2019 Ahmed Labib. All rights reserved.
//

import UIKit

class LoadingIndicator {
    
    private var spinner : UIView?
    
    func showLoading(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let activityIndicator = UIActivityIndicatorView.init(style: .whiteLarge)
        activityIndicator.startAnimating()
        activityIndicator.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(activityIndicator)
            onView.addSubview(spinnerView)
            onView.bringSubviewToFront(spinnerView)
        }
        
        spinner = spinnerView
    }
    
    func removeLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.spinner?.removeFromSuperview()
            self?.spinner = nil
        }
    }
}
