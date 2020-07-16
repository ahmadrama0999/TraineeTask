//
//  LoginViewController.swift
//  TraineeTask
//
//  Created by Ramin Akhmad on 16.07.2020.
//  Copyright © 2020 Ramin Akhmad. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LoginViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let loginButton = FBLoginButton()
        loginButton.center = view.center
        loginButton.permissions = ["public_profile", "email"]
        view.addSubview(loginButton)
        if let token = AccessToken.current, !token.isExpired {
            print("WORK")
            print(token)
        } else {
            print("FAIL LOGIN")
        }
        

        guard let accessToken = FBSDKLoginKit.AccessToken.current else { return }
        let graphRequest = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                      parameters: ["fields": "email, name"],
                                                      tokenString: accessToken.tokenString,
                                                      version: nil,
                                                      httpMethod: .get)
        graphRequest.start { (connection, result, error) -> Void in
            if error == nil {
                guard let data = result as? [String: Any] else { return }
                let user = UserModel(data: data)
                self.nameLabel.text = user.name
            }
            else {
                print("error \(error)")
            }
        }
        
    }
    

    @IBAction func logOutButton(_ sender: Any) {
        LoginManager().logOut()
        nameLabel.text = "Who am I?"
    }
    
}



struct UserModel: Codable {
    let id: String
    let name: String
    let email: String
    
    init(data: [String : Any]) {
        self.id = (data["id"] as? String) ?? ""
        self.name = (data["name"] as? String) ?? ""
        self.email = (data["name"] as? String) ?? ""
    }


    
}
