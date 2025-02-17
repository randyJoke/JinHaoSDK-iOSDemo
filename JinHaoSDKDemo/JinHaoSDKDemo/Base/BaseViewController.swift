//
//  BaseViewController.swift
//  Euphony
//
//  Created by Anthony Benitez on 2/1/22.
//

import UIKit

class BaseViewController: UIViewController {

    // MARK: - Properties
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    public let activityIndicator = RequestSpinnerViewController()
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureBaseController(withTitle: "Base Controller")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - UI Methods
    public func configureBaseController(withTitle title: String, withDefaultStyle isDefaultStyle: Bool = false) {
        self.title = title
//        setNeedsStatusBarAppearanceUpdate()
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .darkGray
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
            navigationController?.navigationBar.compactAppearance = appearance
        } else {
            navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
            navigationController?.navigationBar.backgroundColor = .darkGray
        }
        
        if isDefaultStyle {
            navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
            navigationController?.navigationBar.backgroundColor = .gray
        }
    }
    
    // - MARK: Spinner Methods
    /// Show/Hide spinner methods to compliment visual cues.
    public func showSpinnerView(in viewController: UIViewController) {
        addChild(activityIndicator)
        view.addSubview(activityIndicator.view)
        activityIndicator.view.center(inView: viewController.view)
        view.bringSubviewToFront(activityIndicator.view)
    }
    
    public func hideSpinnerView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
            activityIndicator.willMove(toParent: nil)
            activityIndicator.view.removeFromSuperview()
            activityIndicator.removeFromParent()
        }
    }
}
