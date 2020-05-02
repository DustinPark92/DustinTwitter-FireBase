//
//  LoginController.swift
//  DustinTwitter+FireBase
//
//  Created by Dustin on 2020/05/01.
//  Copyright © 2020 Dustin. All rights reserved.
//

import UIKit
import KakaoOpenSDK
import NaverThirdPartyLogin
import Alamofire

class LoginController: UIViewController {
    //MARK: - Properties
    
    let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
    
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
        button.addTarget(self, action: #selector(handleLogin(_:)), for: .touchUpInside)
        return button
    }()
    
    private let loginButton: KOLoginButton = {
        let button = KOLoginButton()
        button.addTarget(self, action: #selector(touchUpLoginButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
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
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView,passwordContainerView,logInButton,loginButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        view.addSubview(stack)
        stack.anchor(top:logoImageView.bottomAnchor, left: view.leftAnchor ,right: view.rightAnchor, paddingTop: 30 , paddingLeft: 16, paddingRight: 16)
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(left:view.leftAnchor,bottom:view.safeAreaLayoutGuide.bottomAnchor,right: view.rightAnchor)
        
        
        
    }
    
    private func getNaverInfo() {
      guard let isValidAccessToken = loginInstance?.isValidAccessTokenExpireTimeNow() else { return }
      
      if !isValidAccessToken {
        return
      }
      
      guard let tokenType = loginInstance?.tokenType else { return }
      guard let accessToken = loginInstance?.accessToken else { return }
      let urlStr = "https://openapi.naver.com/v1/nid/me"
      let url = URL(string: urlStr)!
      
      let authorization = "\(tokenType) \(accessToken)"
      
      let req = AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization": authorization])

      req.responseJSON { response in
      guard let result = response.value as? [String: Any] else { return }
      guard let object = result["response"] as? [String: Any] else { return }
      guard let name = object["name"] as? String else { return }
      guard let email = object["email"] as? String else { return }
      guard let nickname = object["nickname"] as? String else { return }

      print("\(name)")
      print("\(email)")
      print("\(nickname)")
      }
    }
    
    //MARK: - Selectors
    
    @objc private func handleLogin(_ sender: UIButton) {
        
        loginInstance?.delegate = self
        loginInstance?.requestThirdPartyLogin()
                
    }
    
    @objc func handleSignUp() {
        let controller = RegistrationController()
        navigationController?.pushViewController(controller, animated: true)

    }
    
    @objc private func touchUpLoginButton(_ sender: UIButton) {
      guard let session = KOSession.shared() else {
        return
      }
      
      if session.isOpen() {
        session.close()
      }
      
      session.open { (error) in
        if error != nil || !session.isOpen() { return }
        KOSessionTask.userMeTask(completion: { (error, user) in
            
          guard let user = user,
                let email = user.account?.email,
                let nickname = user.nickname else { return }
            
            let controller = MainTabController()
            self.present(controller, animated: false, completion: nil)
    
         
        })
       
      }
    
    }
    
    
}


extension LoginController: NaverThirdPartyLoginConnectionDelegate {
  // 로그인 버튼을 눌렀을 경우 열게 될 브라우저
  func oauth20ConnectionDidOpenInAppBrowser(forOAuth request: URLRequest!) {
//     let naverSignInVC = NLoginThirdPartyOAuth20InAppBrowserViewController(request: request)!
//     naverSignInVC.parentOrientation = UIInterfaceOrientation(rawValue: UIDevice.current.orientation.rawValue)!
//     present(naverSignInVC, animated: false, completion: nil)
    
    // UPDATE: 2019. 10. 11 (금)
    // UIWebView가 제거되면서 NLoginThirdPartyOAuth20InAppBrowserViewController가 있는 헤더가 삭제되었습니다.
    // 해당 코드 없이도 로그인 화면이 잘 열리는 것을 확인했습니다.
  }
  
  // 로그인에 성공했을 경우 호출
  func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
    print("[Success] : Success Naver Login")
    let controller = MainTabController()
    self.present(controller, animated: true, completion: nil)
    getNaverInfo()
  }
  
  // 접근 토큰 갱신
  func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
    
  }
  
  // 로그아웃 할 경우 호출(토큰 삭제)
  func oauth20ConnectionDidFinishDeleteToken() {
    loginInstance?.requestDeleteToken()
  }
  
  // 모든 Error
  func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
    print("[Error] :", error.localizedDescription)
  }
}
