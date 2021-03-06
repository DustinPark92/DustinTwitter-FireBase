//
//  ActionSheetViewModel.swift
//  DustinTwitter+FireBase
//
//  Created by Dustin on 2020/07/15.
//  Copyright © 2020 Dustin. All rights reserved.
//

import Foundation


struct ActionSheetViewModel {
    private let user: User
    
    var options: [ActionSheetOptions] {
        var results = [ActionSheetOptions]()
        
        if user.isCurrentUser {
            results.append(.delete)
        } else {
            let followOption : ActionSheetOptions = user.isFollowed ? .unfollow(user) : .follow(user)
            results.append(followOption)
            
        }
        
        results.append(.report)
        results.append(.blockUser)
        
        return results
    }
    
    init(user: User) {
        self.user = user
    }
    
    
    
    
}


enum ActionSheetOptions {
    case follow(User)
    case unfollow(User)
    case report
    case delete
    case blockUser
    
    var description : String {
        switch self {
        case .follow(let user):
            return "Follow @\(user.username)"
        case .unfollow(let user):
            return "UnFollow @\(user.username)"
        case .report: return "Report Tweet"
        case .delete: return "Delete Tweet"
        case .blockUser: return "Block User"
            
        }
        
    }
    
}
