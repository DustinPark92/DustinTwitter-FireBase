//
//  TweetHeader.swift
//  DustinTwitter+FireBase
//
//  Created by Dustin on 2020/06/10.
//  Copyright © 2020 Dustin. All rights reserved.
//

import UIKit

class TweetHeader: UICollectionReusableView {
    //MARK: - Properties
    
    var tweet : Tweet? {
        didSet { configure() }
        
    }
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.setDimensions(width: 48, height: 48)
        iv.layer.cornerRadius = 48 / 2
        iv.backgroundColor = .twitterBlue
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleProfileImageTapped))
        iv.addGestureRecognizer(tap)
        iv.isUserInteractionEnabled = true
        
        return iv
    }()
    
    private let fullnameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Dustin"
        
        return label
    }()
    
    private let usernameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Park"
        label.textColor = .lightGray
        return label
    }()
    
    private let captionLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.text = "Some Test Caption"
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .left
        label.text = "6:33 PM - 1/20/2020"
        return label
    }()
    
    private let optionButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .lightGray
        button.setImage(UIImage(named: "down_arrow_24pt"), for: .normal)
        button.addTarget(self, action: #selector(showAlertSheet), for: .touchUpInside)
        return button
    }()
    
    private lazy var statsView: UIView = {
        let view = UIView()
 
        let divider1 = UIView()
        if #available(iOS 13.0, *) {
            divider1.backgroundColor = .systemGroupedBackground
        } else {
            // Fallback on earlier versions
        }
        
        view.addSubview(divider1)
        divider1.anchor(top:view.topAnchor, left:view.leftAnchor,right:view.rightAnchor,paddingLeft: 8,height: 1.0)
        
        let stack = UIStackView(arrangedSubviews: [retweetsLabel,likesLabel])
        stack.axis = .horizontal
        stack.spacing = 12
        view.addSubview(stack)
        stack.centerY(inView: view)
        stack.anchor(left:view.leftAnchor,paddingLeft: 16)
        
        let divider2 = UIView()
        if #available(iOS 13.0, *) {
            divider2.backgroundColor = .systemGroupedBackground
        } else {
            // Fallback on earlier versions
        }
        
        view.addSubview(divider2)
        
        divider2.anchor(top:view.topAnchor, left:view.leftAnchor,right:view.rightAnchor,paddingLeft: 8,height: 1.0)

        return view
    }()
    
    private lazy var retweetsLabel: UILabel = {
        let label = UILabel()
        label.text = "2 retweets"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var likesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "0 likes"
        return label
    }()
    
    private lazy var commentButton: UIButton = {
        let button = createButton(withImageName: "comment")
        button.addTarget(self, action: #selector(handleCommentTapped), for: .touchUpInside)
        return button
    }()
    private lazy var retweetButton: UIButton = {
        let button = createButton(withImageName: "retweet")
        button.addTarget(self, action: #selector(handleRetweetTapped), for: .touchUpInside)
        return button
    }()

    private lazy var likeButton: UIButton = {
        let button = createButton(withImageName: "like")
        button.addTarget(self, action: #selector(handleLikeTapped), for: .touchUpInside)
        return button
    }()

    private lazy var shareButton: UIButton = {
        let button = createButton(withImageName: "share")
        button.addTarget(self, action: #selector(handleShareTapped), for: .touchUpInside)
        return button
    }()

    
    
    

    
    
    
    
    //MARK: - LifeCycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let labelStack = UIStackView(arrangedSubviews: [fullnameLabel,usernameLabel])
        labelStack.axis = .vertical
        labelStack.spacing = -6
        
        let stack = UIStackView(arrangedSubviews: [profileImageView , labelStack])
        stack.spacing = 12
        
        addSubview(stack)
        stack.anchor(top:topAnchor,left: leftAnchor,paddingTop: 16,paddingLeft: 16)
        
        addSubview(captionLabel)
        captionLabel.anchor(top:stack.bottomAnchor,left:leftAnchor,right: rightAnchor,paddingTop: 20,paddingLeft: 16,paddingRight: 16)

        addSubview(dateLabel)
        dateLabel.anchor(top:captionLabel.bottomAnchor, left:leftAnchor,paddingTop: 20,paddingLeft: 16)
        
        addSubview(optionButton)
        optionButton.centerY(inView: stack)
        optionButton.anchor(right:rightAnchor,paddingRight: 8)
        
        addSubview(statsView)
        statsView.anchor(top:dateLabel.bottomAnchor,left:leftAnchor,right: rightAnchor,
            paddingTop: 20 ,height: 40)
        
        let actionStack = UIStackView(arrangedSubviews: [commentButton,retweetButton,likeButton,shareButton])
        
     
        actionStack.spacing = 72
    
        addSubview(actionStack)
        actionStack.centerX(inView: self)
        actionStack.anchor(bottom: bottomAnchor,paddingBottom: 12)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Selectors
    
    @objc func handleProfileImageTapped() {
        
    }
    
    @objc func showAlertSheet() {
        print("show action Sheet")
    }
    
    @objc func handleCommentTapped() {
        
    }
    @objc func handleRetweetTapped() {
        
    }
    @objc func handleLikeTapped() {
        
    }
    @objc func handleShareTapped() {
        
    }
    
    
    //MARK: - Helpers
    
    func createButton(withImageName imageName:String) -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: imageName), for: .normal)
        button.tintColor = .darkGray
        button.setDimensions(width: 20, height: 20)
        return button
    }
    
    func configure() {
        guard let tweet = tweet else { return }
        let viewModel = TweetViewModel(tweet: tweet)
        
        captionLabel.text = tweet.caption
        fullnameLabel.text  = tweet.user.fullname
        usernameLabel.text = viewModel.usernameText
        dateLabel.text = viewModel.headerTimeStamp
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
    }
    
    
}
