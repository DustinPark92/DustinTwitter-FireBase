//
//  ProfileCategory.swift
//  DustinTwitter+FireBase
//
//  Created by Dustin on 2020/06/07.
//  Copyright © 2020 Dustin. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ProfileFilterCell"

protocol profileFilterViewDelegate : class {
    func filterView(_ view: ProfileFilterView, didselect indexPath : IndexPath)
}

class ProfileFilterView: UIView {
    //MARK : - Properteis
    
    weak var delegate : profileFilterViewDelegate?
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero
            , collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    //MARK : - LifeCycles
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
 
        
        collectionView.register(profileFilterCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        let selectedIndexPath = IndexPath(row: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: .left)
        
        addSubview(collectionView)
        collectionView.addConstraintsToFillView(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


//MARK : - UICollectionViewDataSource
extension ProfileFilterView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return profilerFilterOptions.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! profileFilterCell
        let option = profilerFilterOptions(rawValue: indexPath.row)
        cell.option = option
        return cell

    }
}
//MARK : - UICollectionViewDelegate
extension ProfileFilterView : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let count = CGFloat(profilerFilterOptions.allCases.count)
        return CGSize(width: frame.width / count, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
//MARK : - UICollectionViewFlowLayOut
extension ProfileFilterView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.filterView(self, didselect: indexPath)
    }
  

}
