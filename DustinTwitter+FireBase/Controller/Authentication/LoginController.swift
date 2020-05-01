//
//  LoginController.swift
//  DustinTwitter+FireBase
//
//  Created by Dustin on 2020/05/01.
//  Copyright © 2020 Dustin. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    //MARK: - Properties
    
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "TwitterLogo")
        return iv
    }()
    
    private lazy var emailContainerView: UIView = {
        let view = Utilites().inputContainerView(withImage: #imageLiteral(resourceName: "ic_mail_outline_white_2x-1"), textField: emailTextField )
        
        return view
        
    }()
    
    private lazy var passwordContainerView: UIView = {
        let view = Utilites().inputContainerView(withImage: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), textField: passwordTextField )
        
        return view
        
    }()
    
    private let emailTextField : UITextField = Utilites().textField(withPlaceholder: "Email")
    
    
    private let passwordTextField : UITextField =  {
        let tf =  Utilites().textField(withPlaceholder: "Password")
        tf.isSecureTextEntry = true
        
        return tf
    }()
    
    private let logInButton : UIButton = {
        let button = Utilites().buttonUI(setTitle: "Log in")
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    
    private let dontHaveAccountButton: UIButton = {
        let button = Utilites().attributedButton("Don't have an account?", " Sign Up")
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    
    
    
    
    //MARK: - LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .twitterBlue
        //status 창 white로 바뀐다.
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isHidden = true
        
        
        view.addSubview(logoImageView)
        logoImageView.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        logoImageView.setDimensions(width: 150, height: 150)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView,passwordContainerView,logInButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        view.addSubview(stack)
        stack.anchor(top:logoImageView.bottomAnchor, left: view.leftAnchor ,right: view.rightAnchor, paddingTop: 30 , paddingLeft: 16, paddingRight: 16)
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(left:view.leftAnchor,bottom:view.safeAreaLayoutGuide.bottomAnchor,right: view.rightAnchor)
        
    }
    
    //MARK: - Selectors
    
    @objc func handleLogin() {
        print("handle LogIn")
    }
    
    @objc func handleSignUp() {
        let controller = RegistrationController()
        navigationController?.pushViewController(controller, animated: true)

    }
}
