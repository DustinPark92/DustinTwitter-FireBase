//
//  FeedController.swift
//  DustinTwitter+FireBase
//
//  Created by Dustin on 2020/04/30.
//  Copyright © 2020 Dustin. All rights reserved.
//

import UIKit

class FeedController: UIViewController {
    //MARK: - Properties
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        
    }
    
    //MARK: - Helpers
    
    func configureUI() {
  
        let imageView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
    }
}
