//
//  profileHeaderViewModel.swift
//  DustinTwitter+FireBase
//
//  Created by Dustin on 2020/06/08.
//  Copyright © 2020 Dustin. All rights reserved.
//

import UIKit



enum profilerFilterOptions : Int, CaseIterable {
    case tweets
    case replies
    case likes
    
    var description: String{
        switch self {
        case .tweets:
            return "Tweets"
        case .replies:
            return "Tweets &  Replies"
        case .likes:
            return "Likes"
        }
    }
}


struct ProfileHeaderViewModel {
    
    private let user: User
    
    let usernameText: String?
    
    var followingString: NSAttributedString? {
        return attributedText(withValue: user.stats?.folloings ?? 0, text: "following")
    }
    
    var followersString: NSAttributedString? {
        return attributedText(withValue: user.stats?.followers ?? 0, text: "follwers")
    }
    
    var actionButtonTitle: String {
        //if user is current user then set to edit profile
        //else figure out following/not following
        if user.isCurrentUser {
            return "Edit Profile"
            
        }
        if !user.isFollowed && !user.isCurrentUser {
            return "Follow"
        }
        
        if user.isFollowed  {
            return "Following"
        }
        
        return "Loading"
    }
    
    init(user: User) {
        self.user = user
        self.usernameText = "@" + user.username
        
    }
    
    func attributedText(withValue value: Int, text: String) -> NSAttributedString {
        let attributedTitle = NSMutableAttributedString(string: "\(value)", attributes: [.font :
            UIFont.boldSystemFont(ofSize: 14)])
        
        attributedTitle.append(NSMutableAttributedString(string: "  \(text)", attributes: [.font :
            UIFont.boldSystemFont(ofSize: 14), .foregroundColor: UIColor.lightGray]))
        
        
        return attributedTitle
    }
    
    
}
