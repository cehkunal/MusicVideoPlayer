//
//  LoginControllerViewController.swift
//  MusicVideoPlayer
//
//  Created by MacMini Two on 20/04/17.
//  Copyright © 2017 Kunal Pachauri. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class LoginControllerViewController: UIViewController {
    @IBOutlet var userNameTextField: UITextField!
     var ref: FIRDatabaseReference!
    @IBOutlet var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()
       
    }

    @IBAction func loginAction(_ sender: UIButton) {

        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let username = value?["username"] as? String ?? ""
            let user = User.init(username: username)
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        if(ref.child("users").)
        
    
    
    
    }
   
}
