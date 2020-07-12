//
//  UserService.swift
//  DustinTwitter+FireBase
//
//  Created by Dustin on 2020/05/10.
//  Copyright © 2020 Dustin. All rights reserved.
//

import Firebase

typealias DatabaseCompletion = ((Error?, DatabaseReference) -> Void)

struct UserService {
    static let shared = UserService()
    
    func fetchUser(uid : String, completion: @escaping(User) -> Void) {
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
    
    func fetchUsers(completion: @escaping([User]) -> Void) {
        var users = [User]()
        REF_USERS.observe(.childAdded) { snapshot in
            let uid = snapshot.key
            guard let dictionary = snapshot.value as? [String:AnyObject] else { return }
            let user = User(uid: uid, dictionary: dictionary)
            users.append(user)
            completion(users)
        }
    }
    
    func fetchUser(uid: String, completion: @escaping(DatabaseCompletion)) {
        
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        REF_USER_FOLLOWING.child(currentUid).updateChildValues([uid:1]) { (err, ref) in
            REF_USER_FOLLOWERS.child(uid).updateChildValues([currentUid:1], withCompletionBlock: completion)
        }
        
        
    }
    
    func unfollowerUser(uid:String, completion: @escaping(DatabaseCompletion)) {
        
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        REF_USER_FOLLOWING.child(currentUid).child(uid).removeValue { (err, ref) in
            REF_USER_FOLLOWERS.child(uid).child(currentUid).removeValue(completionBlock: completion)
        }
        
    }
    
    func checkIfUserIsFollowed(uid: String, completion: @escaping(Bool) -> Void ) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        REF_USER_FOLLOWING.child(currentUid).child(uid).observeSingleEvent(of: .value) { snapshot in
            print("user followed \(snapshot.exists())")
            completion(snapshot.exists())
        }
        
    }
    
    func fetchUserState(uid: String, completion:@escaping(UserRelationStats) -> Void) {
        REF_USER_FOLLOWERS.child(uid).observeSingleEvent(of: .value) { snapshot in
            
            let followers = snapshot.children.allObjects.count
            REF_USER_FOLLOWING.child(uid).observeSingleEvent(of: .value) { snapshot in
                let following = snapshot.children.allObjects.count
                let stats = UserRelationStats(followers: followers, folloings: following)
                completion(stats)
            }
        
    }
}
}

