//
//  MainTabBarController.swift
//  MyMusic
//
//  Created by jopootrivatel on 20.03.2023.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        tabBar.tintColor = #colorLiteral(red: 1, green: 0, blue: 0.3776089847, alpha: 1)
        
        viewControllers = [
            generateViewController(
                rootViewController: SearchMusicViewController(),
                image: UIImage(imageLiteralResourceName: "search"),
                title: "Search"
            ),
            generateViewController(
                rootViewController: ViewController(),
                image: UIImage(imageLiteralResourceName: "library"),
                title: "Library"
            )
        ]
    }
    
    private func generateViewController(rootViewController: UIViewController, image: UIImage, title: String) -> UIViewController {
        
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.image = image
        navigationVC.tabBarItem.title = title
        rootViewController.navigationItem.title = "Search"
        navigationVC.navigationBar.prefersLargeTitles = true
        
        return navigationVC
    }
    
}
