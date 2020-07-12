//
//  profilerController.swift
//  DustinTwitter+FireBase
//
//  Created by Dustin on 2020/06/06.
//  Copyright © 2020 Dustin. All rights reserved.
//

import UIKit

private let reuseIdentifier = "TweetCell"
private let headerIdentifier = "ProfileHeader"

class profileController: UICollectionViewController {
    
    
    //MARK: - Properties
    private var user: User
    
    private var tweets = [Tweet]() {
        //카운트를 늦게 받아오기때문에 리로드 해줘야 한다.
        didSet { collectionView.reloadData() }
    }
    
    
    
    //MARK: - LifeCycle
    
    init(user:User) {
        self.user = user
        super.init(collectionViewLayout:UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        fetchTweets()
        checkIfUserFollowed()
        fetchUserStats()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isHidden = true
    }
    
    //MARK: - API
    
    func fetchTweets() {
        TweetService.shared.fetchTweets(forUser: user) { tweets in
            self.tweets = tweets
        }
    }
    
    func checkIfUserFollowed() {
        UserService.shared.checkIfUserIsFollowed(uid: user.uid) { isFollowed in
            self.user.isFollowed = isFollowed
            self.collectionView.reloadData()
        }
    }
    
    func fetchUserStats() {
        UserService.shared.fetchUserState(uid: user.uid) { stats in
            self.user.stats = stats
            self.collectionView.reloadData()
        }
     
    }
    
    
    
    
    //MARK: - Helerper
    
    func configureCollectionView() {
        
        collectionView.backgroundColor = .white
        collectionView.contentInsetAdjustmentBehavior = .never
        
        
        collectionView.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        
    }
    

}


//MARK: - CollectionViewDataSource
extension profileController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tweets.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TweetCell
        cell.tweet = tweets[indexPath.row]
        return cell
        
    }
    
    
}

//MARK : - UICollectionView Delegate

extension profileController {
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath)
            as! ProfileHeader
        header.delegate = self
        
        header.user = user
        return header
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension profileController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width , height: 350)
    }
    
}


extension profileController: ProfileHeaderDelegate {
    
    func handleEditProfileFollow(_ header: ProfileHeader) {
        
        if user.isCurrentUser {
            print("lalala")
            return
        } else {
            
        
        }
        

        if user.isFollowed {
            UserService.shared.unfollowerUser(uid: user.uid) { (err, ref) in
                self.user.isFollowed = false
                header.editProfileFollowButton.setTitle("Follow", for: .normal)
                self.collectionView.reloadData()
            }
        } else {
            UserService.shared.fetchUser(uid: user.uid) { (ref, err) in
                
                self.user.isFollowed = true
                header.editProfileFollowButton.setTitle("Following", for: .normal)
                self.collectionView.reloadData()
                
            }
        }
        
    }
    
    
    
    
    
    func handleDismissal() {
        navigationController?.popViewController(animated: true)
    }
}
