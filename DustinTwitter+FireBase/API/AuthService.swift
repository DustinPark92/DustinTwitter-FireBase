//
//  AuthService.swift
//  DustinTwitter+FireBase
//
//  Created by Dustin on 2020/05/04.
//  Copyright © 2020 Dustin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


struct AuthCredential {
    let email: String
    let password: String
    let fullname: String
    let username: String
    let profileImage: UIImage
}



struct AuthService {
    static let shared = AuthService()
    
    func logUserIn(withEmail email: String, password: String,completion: AuthDataResultCallback?) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    func registerUser(credentials: AuthCredential, completion : @escaping(Error?, DatabaseReference) -> Void) {
        
        guard let imageData = credentials.profileImage.jpegData(compressionQuality: 0.3) else { return }
          
          let filename = NSUUID().uuidString
          let storageRef = STORAGE_PROFILE_IMAGES.child(filename)
          
        storageRef.putData(imageData, metadata: nil) { (meta, error) in
            storageRef.downloadURL { (url, error) in
                guard let profileImageUrl = url?.absoluteString else { return }
                
                Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { (result, error) in
                    if let error = error {
                        print("\(error.localizedDescription)")
                        
                        return
                    }
                    
                    guard let uid = result?.user.uid else { return }
                    let values = ["email":credentials.email,"username":credentials.username,"fullname":credentials.fullname,"profileImageUrl":profileImageUrl]
                    REF_USERS.child(uid).updateChildValues(values, withCompletionBlock: completion)
                    
                }
            }
        }
    }
}
