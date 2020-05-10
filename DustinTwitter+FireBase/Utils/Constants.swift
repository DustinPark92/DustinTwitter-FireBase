//
//  Constants.swift
//  DustinTwitter+FireBase
//
//  Created by Dustin on 2020/05/04.
//  Copyright © 2020 Dustin. All rights reserved.
//

import Firebase
import FirebaseDatabase


let STORAGE_REF = Storage.storage().reference()
let STORAGE_PROFILE_IMAGES = STORAGE_REF.child("profile_images")

let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("users")

