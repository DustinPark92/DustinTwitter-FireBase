//
//  ProfileHeader.swift
//  DustinTwitter+FireBase
//
//  Created by Dustin on 2020/06/07.
//  Copyright © 2020 Dustin. All rights reserved.
//

import UIKit

protocol ProfileHeaderDelegate: class {
    func handleDismissal()
    func handleEditProfileFollow(_ header: ProfileHeader)
}

class ProfileHeader: UICollectionReusableView {
    
    //MARK : - Properties
    
    private let filterBar = ProfileFilterView()
    
    var user: User? {
        didSet {
            configure()
        }
    }
    weak var delegate : ProfileHeaderDelegate?
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .twitterBlue
        view.addSubview(backButton)
        backButton.anchor(top:view.topAnchor,left:view.leftAnchor,
                          paddingTop: 42, paddingLeft: 10)
        backButton.setDimensions(width: 30, height: 30)
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "baseline_arrow_back_white_24dp").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleDissmissal), for: .touchUpInside)
        return button
    }()
    
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        iv.layer.borderColor = UIColor.white.cgColor
        iv.layer.borderWidth = 4
        
        return iv
    }()
    
    lazy var editProfileFollowButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Loading", for: .normal)
        button.layer.borderColor = UIColor.twitterBlue.cgColor
        button.layer.borderWidth = 1.25
        button.setTitleColor(.twitterBlue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleEditProfileFollow), for: .touchUpInside)
        
        return button
    }()
    
    private let fullnameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        
        return label
    }()
    
    private let usernameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .lightGray
        return label
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 3
        label.text = "This is a user bio that will span more than one line for test purposes"
        return label
    }()
    
    private let underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .twitterBlue
       return view
    }()
    
    private let followingLabel: UILabel = {
        let label = UILabel()
        let followTop = UITapGestureRecognizer(target: self, action: #selector(handleFollowingTapped))
        label.addGestureRecognizer(followTop)
        return label
    }()
    
    
    private let followersLabel: UILabel = {
        let label = UILabel()
        let followTop = UITapGestureRecognizer(target: self, action: #selector(handleFollowersTapped))
        label.addGestureRecognizer(followTop)
        return label
    }()
    
    
    //MARK : - LifeCycles
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        filterBar.delegate = self
        
        addSubview(containerView)
        containerView.anchor(top:topAnchor,left:leftAnchor,right: rightAnchor,height: 108)
        
        addSubview(profileImageView)
        profileImageView.anchor(top:containerView.bottomAnchor, left:leftAnchor, paddingTop: -24, paddingLeft: 8)
        profileImageView.setDimensions(width: 80 ,height: 80)
        profileImageView.layer.cornerRadius = 80 / 2
        
        
        addSubview(editProfileFollowButton)
        editProfileFollowButton.anchor(top:containerView.bottomAnchor,right: rightAnchor,paddingTop: 12,
                                       paddingRight: 12)
        
        editProfileFollowButton.setDimensions(width: 100, height: 36)
        editProfileFollowButton.layer.cornerRadius = 36 / 2
        
        let userDetailsStack = UIStackView(arrangedSubviews: [fullnameLabel,usernameLabel,bioLabel])
        
        userDetailsStack.axis = .vertical
        userDetailsStack.distribution = .fill
        userDetailsStack.spacing = 4
        
        addSubview(userDetailsStack)
        userDetailsStack.anchor(top:profileImageView.bottomAnchor,left: leftAnchor,right: rightAnchor,paddingTop: 8, paddingLeft: 12, paddingRight: 12)
        
        
        let followerStack = UIStackView(arrangedSubviews: [followingLabel,followersLabel])
        followerStack.axis = .horizontal
        followerStack.distribution = .fillEqually
        followerStack.spacing = 8
        
        addSubview(followerStack)
        followerStack.anchor(top: userDetailsStack.bottomAnchor , left:leftAnchor,paddingTop: 8,paddingLeft: 12)
        
        
        addSubview(filterBar)
        filterBar.anchor(left: leftAnchor, bottom: bottomAnchor , right: rightAnchor , height:  50)
        
        addSubview(underlineView)
        underlineView.anchor(left:leftAnchor,bottom: bottomAnchor,width: frame.width / 3 , height:  2)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK : - Selectors
    
    @objc func handleDissmissal() {
        delegate?.handleDismissal()
    }
    
    @objc func handleEditProfileFollow() {
        delegate?.handleEditProfileFollow(self)
    }
    
    @objc func handleFollowersTapped() {
        
    }
    
    @objc func handleFollowingTapped() {
        
    }
    
//MARK: - Helpers
    func configure() {
        guard let user = user else { return }
        
        let viewModel = ProfileHeaderViewModel(user: user)
        
        
        profileImageView.sd_setImage(with: user.profileImageUrl)
        editProfileFollowButton.setTitle(viewModel.actionButtonTitle, for: .normal)
        followingLabel.attributedText = viewModel.followingString
        followersLabel.attributedText = viewModel.followersString
        
        fullnameLabel.text = user.fullname
        usernameLabel.text = viewModel.usernameText
    }
    
}

//MARK : - profileFilterViewDelegate
extension ProfileHeader: profileFilterViewDelegate {
    func filterView(_ view: ProfileFilterView, didselect indexPath: IndexPath) {
        guard let cell = view.collectionView.cellForItem(at: indexPath) as? profileFilterCell else {
            return
        }
        
        let xPosition = cell.frame.origin.x
        UIView.animate(withDuration: 0.3) {
            self.underlineView.frame.origin.x = xPosition
            
        }
        
    }
}
