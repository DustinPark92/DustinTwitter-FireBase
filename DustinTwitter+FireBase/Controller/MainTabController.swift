//
//  MainTabController.swift
//  DustinTwitter+FireBase
//
//  Created by Dustin on 2020/04/30.
//  Copyright © 2020 Dustin. All rights reserved.
//

import UIKit

class MainTabController: UITabBarController {
    
    //MARK: - Properties
    
    let actionButton : UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = .twitterBlue
        button.setImage(UIImage(named: "new_tweet"), for: .normal)
        button.addTarget(self, action: #selector(actionBUttonTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureViewController()
        view.backgroundColor = .red
    }
    
    func configureUI() {
        view.addSubview(actionButton)
        actionButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingBottom: 64, paddingRight: 16,
            width: 56,
            height: 56)
        
        actionButton.layer.cornerRadius = 56 / 2
        
        
        
    }
    
    //MARK: - Helpers
    
    
    func configureViewController() {
        
        //tab bar 박기
        let feed = FeedController()
        let explore = ExploreController()
        let notifications = NotificationController()
        let conversations = ConversationsController()
        
        let nav1 = templateNavigationController(image: UIImage(named: "home_unselected"), rootViewController: feed)
        let nav2 = templateNavigationController(image: UIImage(named: "search_unselected"), rootViewController: explore)
        let nav3 = templateNavigationController(image: UIImage(named: "like_unselected"), rootViewController: notifications)
        let nav4 = templateNavigationController(image: UIImage(named: "ic_mail_outline_white_2x-1"), rootViewController: conversations)
        viewControllers = [nav1,nav2,nav3,nav4]
        
        
    }
    
    func templateNavigationController(image: UIImage?, rootViewController: UIViewController) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
        nav.navigationBar.barTintColor = .white
        
        return nav
    }
    
    //MARK : - Selectors
    
    @objc func actionBUttonTapped() {
        print(123)
        
    }

}
