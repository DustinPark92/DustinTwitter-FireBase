//
//  ProfileFilterCell.swift
//  DustinTwitter+FireBase
//
//  Created by Dustin on 2020/06/07.
//  Copyright © 2020 Dustin. All rights reserved.
//

import UIKit

class profileFilterCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    var option: profilerFilterOptions! {
        didSet { titleLabel.text = option.description }
    }
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            titleLabel.font = isSelected ? UIFont.boldSystemFont(ofSize: 16) : UIFont.systemFont(ofSize: 14)
            titleLabel.textColor = isSelected ? .twitterBlue : .lightGray
            
        }
    }
    
    
    //MARK: - LifeCycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        

        addSubview(titleLabel)
        titleLabel.center(inView: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
