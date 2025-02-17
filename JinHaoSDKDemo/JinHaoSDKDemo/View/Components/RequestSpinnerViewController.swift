//
//  RequestSpinnerViewController.swift
//  Euphony
//
//  Created by Anthony Benitez on 4/4/22.
//

import UIKit

class RequestSpinnerViewController: UIViewController {
    
    // MARK: - Properties
    var activityIndicatorView = UIActivityIndicatorView()

    // MARK: - Methods
    override func loadView() {
        view = UIView()
        activityIndicatorView = UIActivityIndicatorView(style: .large)
        
        view.addSubview(activityIndicatorView)
        activityIndicatorView.setDimensions(width: 64, height: 64)
        activityIndicatorView.center(inView: view)
        activityIndicatorView.startAnimating()
    }
    
}
