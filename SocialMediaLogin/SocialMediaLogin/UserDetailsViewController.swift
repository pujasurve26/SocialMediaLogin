//
//  UserDetailsViewController.swift
//  SocialMediaLogin
//
//  Created by Puja Kalpesh Surve on 23/11/21.
//

import UIKit

class UserDetailsViewController: UIViewController {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var imgProfilePic: UIImageView!
    
    var dict: [String : Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setData()
    }
  
    func setData() {
        lblName.text = dict["name"] as! String
        lblEmail.text = dict["email"] as! String
        
        let picture = dict["picture"] as? [String: Any]
        let data = picture?["data"] as? [String: Any]
        let imgUrl = data?["url"] as? String
        
        if let url = URL(string: imgUrl ?? "") {
            let data = try? Data(contentsOf: url)
            imgProfilePic.image = UIImage(data: data!)
        }
    }

}
