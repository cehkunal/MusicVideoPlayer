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

        ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            print(value!)
        
            if (value?[self.userNameTextField.text!]) != nil
            {
                print("user found")
                
                let originalPassword : String = value?[self.userNameTextField.text!] as! String
                let password  : String = self.passwordTextField.text!
                
                if(password.caseInsensitiveCompare(originalPassword) == ComparisonResult.orderedSame)
                {
                    print("Successfully logged in \(self.userNameTextField.text!)")
                    
                    //Performing Segue
                    
                    self.performSegue(withIdentifier: "enterApp", sender: nil)
                    
                }
                else
                {
                    let alert = UIAlertController(title: "Sangeet", message: "The Password is Incorrect. Please Try Again", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
            else
            {
                let alert = UIAlertController(title: "Sangeet", message: "User Not Found In Database. Please Register First", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }) { (error) in
            print(error.localizedDescription)
        }
        
    
    
    
    }
    
   
}
