//
//  UserService.swift
//  DustinTwitter+FireBase
//
//  Created by Dustin on 2020/05/10.
//  Copyright © 2020 Dustin. All rights reserved.
//

import Firebase

struct UserService {
    static let shared = UserService()
    
    func fetchUser(completion: @escaping(User) -> Void) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        REF_USERS.child(uid).observeSingleEvent(of: .value) { snapshot in
            print("\(snapshot)")
            guard let dictionary = snapshot.value as? [String:AnyObject] else { return }
            print("\(dictionary)")
            guard let username = dictionary["username"] as? String else { return }
            print("\(username)")
            
            
            let user = User(uid: uid, dictionary: dictionary)
            completion(user)
            print("\(user.username)")
            print("\(user.fullname)")
            
        }
        
    }
}
