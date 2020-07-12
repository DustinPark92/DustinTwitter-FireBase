//
//  TweetViewModel.swift
//  DustinTwitter+FireBase
//
//  Created by Dustin on 2020/06/06.
//  Copyright © 2020 Dustin. All rights reserved.
//

import UIKit

struct TweetViewModel {
    let tweet: Tweet
    let user : User
    
    var profileImageUrl : URL? {
        return tweet.user.profileImageUrl
    }
    
    var timestamp : String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute,.hour,.day,.weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        let now = Date()
        return formatter.string(from: tweet.timestamp, to: now) ?? "2m"
    }
    
    var usernameText: String {
        return " @\(user.username)"
    }
    
    var userInfoText: NSAttributedString {
        let title = NSMutableAttributedString(string: user.fullname, attributes: [.font:UIFont.boldSystemFont(ofSize: 14)])
        
        
        //Title옆에 흐린 회색 추가한거
        title.append(NSAttributedString(string: " @\(user.username)", attributes: [.font:UIFont.boldSystemFont(ofSize: 14), .foregroundColor: UIColor.lightGray]))
        //옆에 시간 추가하기
         title.append(NSAttributedString(string: " ・ \(timestamp)", attributes: [.font:UIFont.boldSystemFont(ofSize: 14), .foregroundColor: UIColor.lightGray]))
        
    
        return title
    }
    var headerTimeStamp: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a ・ MM/dd/yyyy"
        return formatter.string(from: tweet.timestamp)
    }
    
    init(tweet: Tweet) {
        self.tweet = tweet
        self.user = tweet.user
        
    }
}
