//
//  TweetService.swift
//  DustinTwitter+FireBase
//
//  Created by Dustin on 2020/05/10.
//  Copyright © 2020 Dustin. All rights reserved.
//

import Firebase

struct TweetService {
    static let shared = TweetService()
    
    func uploadTweet(caption: String,type: UploadTweetConfiguration , compltion:@escaping(DatabaseCompletion)) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let values = ["uid":uid,
                      "timestamp":Int(NSDate().timeIntervalSince1970),
                      "likes":0,
                      "retweets":0,
                      "caption":caption] as [String: Any]
        
        switch type {
        case .tweet:

            
            REF_TWEETS.childByAutoId().updateChildValues(values) { (err, ref) in
                //update user-tweet structure after tweet upload complete
                guard let tweetID = ref.key else { return }
                REF_USER_TWEETS.child(uid).updateChildValues([tweetID: 1], withCompletionBlock: compltion)
            }
            
        case .reply(let tweet):
            REF_TWEET_REPLIES.child(tweet.tweetID).childByAutoId().updateChildValues(values, withCompletionBlock: compltion)
   
        }
        

    }
    
    func fetchTweets(completion: @escaping([Tweet]) -> Void) {
        var tweets = [Tweet]()
        
        //.childAdded 새로운 위치에 추가 될 때 사용5
        REF_TWEETS.observe(.childAdded) { snapshot in
            print("\(snapshot.value)")
            guard let dictionary = snapshot.value as? [String:Any] else { return }
            guard let uid = dictionary["uid"] as? String else { return }
            let tweetID = snapshot.key
            
            //우리가 필요한 값을 Tweet->에가서 찾는다.
            let tweet = snapshot.key
            
            UserService.shared.fetchUser(uid: uid) { user in
                let tweet = Tweet(user: user, tweetID: tweetID, dictionary: dictionary)
                tweets.append(tweet)
                completion(tweets)
            }
    
        }
    }
    
    func fetchTweet(withTweetID tweetID: String, completion: @escaping(Tweet) -> Void) {
        
        REF_TWEETS.child(tweetID).observeSingleEvent(of: .value) { snapshot in
             guard let dictionary = snapshot.value as? [String:Any] else { return }
            guard let uid = dictionary["uid"] as? String else { return }
            let tweetID = snapshot.key
            UserService.shared.fetchUser(uid: uid) { user in
                let tweet = Tweet(user: user, tweetID: tweetID, dictionary: dictionary)
                completion(tweet)
            }
        }
        
    }
    
    func fetchTweets(forUser user: User, completion: @escaping([Tweet]) -> Void) {
        var tweets = [Tweet]()
        
        //-> childAdded for loop 처럼 안겹치게 계속 생성
        REF_USER_TWEETS.child(user.uid).observe(.childAdded) { snapshot in
            let tweetID = snapshot.key
            REF_TWEETS.child(tweetID).observeSingleEvent(of: .value) { snapshot in
                self.fetchTweet(withTweetID: tweetID) { tweet in
                    tweets.append(tweet)
                    completion(tweets)
                }
            }
        }
    }
    
    func fetchReplies(forTweet tweet: Tweet, completion: @escaping([Tweet]) -> Void) {
        var tweets = [Tweet]()
        REF_TWEET_REPLIES.child(tweet.tweetID).observe(.childAdded) { snapshot in
            guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
            guard let uid = dictionary["uid"] as? String else { return }
            let tweetID = snapshot.key
            
            UserService.shared.fetchUser(uid: uid) { user in
                let tweet = Tweet(user: user, tweetID: tweetID, dictionary: dictionary)
                tweets.append(tweet)
                completion(tweets)
            }
        }
    }
    
    func likeTweet(tweet: Tweet, completion: @escaping(DatabaseCompletion)) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let likes = tweet.didLike ? tweet.likes - 1 : tweet.likes + 1
        REF_TWEETS.child(tweet.tweetID).child("likes").setValue(likes)
        
        if tweet.didLike {
            // unlike tweet
            REF_USER_LIKES.child(uid).child(tweet.tweetID).removeValue { (err, ref) in
                REF_TWEET_LIKES.child(tweet.tweetID).removeValue(completionBlock: completion)
            }
            
        } else {
            // like tweet
            REF_USER_LIKES.child(uid).updateChildValues([tweet.tweetID : 1]) { (err, ref) in
                REF_TWEET_LIKES.child(tweet.tweetID).updateChildValues([uid:1], withCompletionBlock: completion)
            }
        }
        
        
        
    }
    
    func checkIfUserLikedTweet(_ tweet: Tweet, completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        REF_USER_LIKES.child(uid).child(tweet.tweetID).observeSingleEvent(of: .value) { Snapshot in
            completion(Snapshot.exists())
        }
    }
    
}
