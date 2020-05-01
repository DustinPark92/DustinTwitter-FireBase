//
//  Utilites.swift
//  DustinTwitter+FireBase
//
//  Created by Dustin on 2020/05/01.
//  Copyright © 2020 Dustin. All rights reserved.
//

import UIKit


class Utilites {
    
    func inputContainerView(withImage image : UIImage , textField: UITextField) -> UIView {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let iv = UIImageView()
        iv.image = image
        view.addSubview(iv)
        iv.anchor(left: view.leftAnchor , bottom: view.bottomAnchor , paddingLeft: 8 , paddingBottom: 8)
        iv.setDimensions(width: 24, height: 24)
        
        

        view.addSubview(textField)
        textField.anchor(left: iv.rightAnchor,bottom: view.bottomAnchor,right:view.rightAnchor,paddingLeft: 8,paddingBottom: 8)
        textField.setDimensions(width: 24, height: 24)
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.textColor = .white
        
        
        
        let sv = UIView()
        view.addSubview(sv)
        sv.backgroundColor = .white
        sv.anchor(left:view.leftAnchor, bottom:view.bottomAnchor,right:view.rightAnchor,paddingLeft:8,height: 0.75)
       
        
        
        return view
    }
    
    func textField(withPlaceholder placeholder : String) -> UITextField {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
            return tf
    }
    
    func attributedButton(_ firstPart: String, _ secondPart: String) -> UIButton {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: firstPart, attributes: [NSAttributedString.Key.font :UIFont.systemFont(ofSize: 16),NSAttributedString.Key.foregroundColor: UIColor.white])
        
        attributedTitle.append(NSMutableAttributedString(string: secondPart, attributes: [NSAttributedString.Key.font :UIFont.boldSystemFont(ofSize: 16),NSAttributedString.Key.foregroundColor: UIColor.white]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        
        return button
    }
    
    func buttonUI(setTitle title: String) -> UIButton {
        
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.twitterBlue, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.anchor(height:50)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)

        return button
    }
    
}
