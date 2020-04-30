//
//  NotificationController.swift
//  DustinTwitter+FireBase
//
//  Created by Dustin on 2020/04/30.
//  Copyright © 2020 Dustin. All rights reserved.
//
import UIKit

class NotificationController: UIViewController {
    //MARK: - Properties
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
       configureUI()
    }
    
    //MARK: - Helpers
    
    func configureUI() {
       
        navigationItem.title = "Notifications"
    }
}
