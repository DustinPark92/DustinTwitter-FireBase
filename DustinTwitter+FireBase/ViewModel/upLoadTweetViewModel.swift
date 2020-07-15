//
//  upLoadTweetViewModel.swift
//  DustinTwitter+FireBase
//
//  Created by Dustin on 2020/07/13.
//  Copyright © 2020 Dustin. All rights reserved.
//

import UIKit

enum UploadTweetConfiguration {
    case tweet
    case reply(Tweet)
}

struct UploadTweetViewModel {
    let actionButtonTitle : String
    let placeholderText : String
    var shouldShowReplyLabel : Bool
    var replyText : String?
    
    init(config: UploadTweetConfiguration) {
        switch config {
        case .tweet:
            actionButtonTitle = "Tweet"
            placeholderText = "what a happening"
            shouldShowReplyLabel = false
            
        case .reply(let tweet):
            actionButtonTitle = "Reply"
            placeholderText = "Tweet your reply"
            shouldShowReplyLabel = true
            replyText = "Replying to @\(tweet.user.username)"
        }
    }
}
