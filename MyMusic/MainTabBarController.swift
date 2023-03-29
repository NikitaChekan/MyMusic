//
//  MainTabBarController.swift
//  MyMusic
//
//  Created by jopootrivatel on 20.03.2023.
//

import UIKit

protocol MainTabBarControllerDelegate: AnyObject {
    func minimizeTrackDetailController()
    
}

class MainTabBarController: UITabBarController {
    
    let searchVC: SearchViewController = SearchViewController.loadFromStoryboard()
    
    
    private var minimizedTopAnchorConstraint: NSLayoutConstraint!
    private var maximizedTopAnchorConstraint: NSLayoutConstraint!
    private var bottomAnchorConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        tabBar.tintColor = #colorLiteral(red: 1, green: 0, blue: 0.3776089847, alpha: 1)
        
        viewControllers = [
            generateViewController(
                rootViewController: searchVC,
                image: UIImage(imageLiteralResourceName: "search"),
                title: "Search"
            ),
            generateViewController(
                rootViewController: ViewController(),
                image: UIImage(imageLiteralResourceName: "library"),
                title: "Library"
            )
        ]
        
        setupTrackDetailView()
    }
    
    private func generateViewController(rootViewController: UIViewController, image: UIImage, title: String) -> UIViewController {
        
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.image = image
        navigationVC.tabBarItem.title = title
        rootViewController.navigationItem.title = "Search"
        navigationVC.navigationBar.prefersLargeTitles = true
        
        return navigationVC
    }
    
    private func setupTrackDetailView() {
        
        let trackDetailView: TrackDetailView = TrackDetailView.loadFromNib()
        trackDetailView.backgroundColor = .green
        trackDetailView.tabBarDelegate = self
        trackDetailView.delegate = searchVC
        
        view.insertSubview(trackDetailView, belowSubview: tabBar)
        
        trackDetailView.translatesAutoresizingMaskIntoConstraints = false
        
        maximizedTopAnchorConstraint = trackDetailView.topAnchor.constraint(equalTo: view.topAnchor)
        minimizedTopAnchorConstraint = trackDetailView.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -64)
    
        bottomAnchorConstraint = trackDetailView.bottomAnchor.constraint(
            equalTo: view.bottomAnchor,
            constant: view.frame.height
        )
        
        maximizedTopAnchorConstraint.isActive = true
        bottomAnchorConstraint.isActive = true
        
        trackDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        trackDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    }
}

extension MainTabBarController: MainTabBarControllerDelegate {
    
    func minimizeTrackDetailController() {
        
        maximizedTopAnchorConstraint.isActive = false
        minimizedTopAnchorConstraint.isActive = true
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 1,
            options: .curveEaseOut) {
                self.view.layoutIfNeeded()
            }
    }
    
}
