//
//  ViewController.swift
//  SocialMediaLogin
//
//  Created by Puja Kalpesh Surve on 23/11/21.
//

import UIKit
import FacebookLogin
import GoogleSignIn

class SocialMediaLoginViewController: UIViewController {
    
    @IBOutlet weak var viwMain : UIView!
    @IBOutlet weak var txtUsername : UITextField!
    @IBOutlet weak var txtPassword : UITextField!
    @IBOutlet weak var viwUsername : UIView!
    @IBOutlet weak var viwPassword : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSocialLogin()
        
        viwMain.setShadow()
        viwUsername.setShadow()
        viwPassword.setShadow()
    }
    
    
    func setSocialLogin() {
        let colorPink = UIColor(red: 219/255, green: 64/255, blue: 143/255, alpha: 1.0)
        // Add a custom facebook login button to your app
        let loginButtonFacebook = UIButton(type: .custom)
        loginButtonFacebook.backgroundColor = .white
        loginButtonFacebook.setTitleColor(colorPink, for: UIControl.State.normal)
        loginButtonFacebook.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        loginButtonFacebook.center =  CGPoint(x: view.center.x, y: view.frame.height - 240)
        loginButtonFacebook.setTitle("Login with Facebook", for: .normal)
        
        // Handle clicks on the button
        loginButtonFacebook.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        view.addSubview(loginButtonFacebook)
        
        // Add a custom gogle login button to your app
        let loginButtonGoogle = UIButton(type: .custom)
        loginButtonGoogle.backgroundColor = .white
        
        loginButtonGoogle.setTitleColor(colorPink, for: UIControl.State.normal)
        loginButtonGoogle.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        loginButtonGoogle.center =  CGPoint(x: view.center.x, y: view.frame.height - 170)
        loginButtonGoogle.setTitle("Login with Google", for: .normal)
        // Handle clicks on the button
        loginButtonGoogle.addTarget(self, action: #selector(loginButtonGoogleClick), for: .touchUpInside)
        view.addSubview(loginButtonGoogle)
    }
    
    /// This method is used to handle google login
    @objc func loginButtonGoogleClick() {
        let signInConfig = GIDConfiguration.init(clientID: "148674078750-g9koua7b5uq26d8tjkofpngsnev4lvup.apps.googleusercontent.com")
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
            guard error == nil else { return }
            let dict: [String: Any] = ["name": user?.profile?.name, "email": user?.profile?.email]
            self.gotoDetails(dict: dict)
        }
        
    }
    
    func gotoDetails(dict: [String: Any]) {
        let story = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "UserDetailsViewController") as! UserDetailsViewController
        vc.dict = dict
        navigationController?.pushViewController(vc, animated: true)
    }
    
    /// This method is used to handle facebook login
    @objc func loginButtonClicked() {
        let manager = LoginManager()
        manager.logIn(permissions: [Permission.email, Permission.publicProfile], viewController: nil) { result in
            let request = GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, email, picture.type(large)"])
            request.start { conne, result, error in
                guard let Info = result as? [String: Any] else { return }
                self.gotoDetails(dict: Info)
            }
        }
    }
    
    @IBAction func btnSigninTapped(_ sender: UIButton) {
        let dict : [String: Any] = ["name": txtUsername.text, "email": txtPassword.text]
        gotoDetails(dict: dict)
    }
    
}
extension UIView {
    
    func setShadow() {
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize.init(width: 0, height: 0)
        self.layer.shadowRadius = 3.0
        self.layer.shadowOpacity = 0.5
        self.layer.cornerRadius = 15
        
    }
}


