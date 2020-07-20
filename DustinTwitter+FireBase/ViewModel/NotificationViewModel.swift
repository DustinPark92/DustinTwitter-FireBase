
//
//  NotificationViewMOdel.swift
//  DustinTwitter+FireBase
//
//  Created by Dustin on 2020/07/20.
//  Copyright © 2020 Dustin. All rights reserved.
//

import UIKit

struct NotificationViewModel {
    private let notification: Notification
    private let type : NotificationType
    private let user : User
    
    var timestampString: String? {
        let formatter = DateComponentsFormatter()
            formatter.allowedUnits = [.second, .minute,.hour,.day,.weekOfMonth]
            formatter.maximumUnitCount = 1
            formatter.unitsStyle = .abbreviated
            let now = Date()
            return formatter.string(from: notification.timestamp, to: now) ?? "2m"
        
    }
    
    var notificationMessage: String {
        switch type {
        
        case .follow:
            return "started Following you"
        case .like:
            return "Liked one of your tweets"
        case .reply:
            return "replie to your tweet"
        case .retweet:
            return "retweeted your tweet"
        case .mention:
            return "mentioned your in a tweet"
        }
    }
    
    var notificationText: NSAttributedString? {
        guard let timestamp = timestampString else { return nil}
        let attributedText = NSMutableAttributedString(string: user.username, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 12)])
        attributedText.append(NSMutableAttributedString(string: notificationMessage, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 12)]))
        attributedText.append(NSMutableAttributedString(string: " \(timestamp)", attributes: [NSMutableAttributedString.Key.font: UIFont.systemFont(ofSize: 12), NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
        return attributedText
    }
    
    var profileImageUrl: URL?{
        return user.profileImageUrl
    }
    
    var shouldHideFollowButton: Bool {
        return type != .follow
    }
    
    var followedButtonText: String {
        return user.isFollowed ? "Following" : "Follow"
    }
    
    init(notification: Notification) {
        self.notification = notification
        self.type = notification.type
        self.user = notification.user
        
    }
    
}
