//
//  RegistrationViewController.swift
//  MusicVideoPlayer
//
//  Created by MacMini Two on 20/04/17.
//  Copyright © 2017 Kunal Pachauri. All rights reserved.
//

import UIKit
import FirebaseDatabase


class RegistrationViewController: UIViewController {
    var ref: FIRDatabaseReference!

    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        ref = FIRDatabase.database().reference()
    
    
    }

   
    @IBAction func registerAction(_ sender: UIButton) {
        
        
        if((userNameTextField.text == "")||(passwordTextField.text == ""))
        {
            let alert = UIAlertController(title: "Sangeet", message: "Username Or Password cannot be blank", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
            
            
            
            ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                let value = snapshot.value as? NSDictionary
                print(value!)
                
                if ((value?[self.userNameTextField.text!]) != nil)
                {
                    print("user found")
                    
                    
                        let alert = UIAlertController(title: "Sangeet", message: "The UserName is Already Occupied. Please try a different User Name", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    
                }
                else
                {
                    self.ref.child("users").child(self.userNameTextField.text!).setValue(self.passwordTextField.text)
                    
                        self.performSegue(withIdentifier: "signIn", sender: nil)
                }
            }) { (error) in
                print(error.localizedDescription)
            }

            
            
            
            
            
            
            
            
            
            
                    }
    }

}
