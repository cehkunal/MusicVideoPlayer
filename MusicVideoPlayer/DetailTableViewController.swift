//
//  DetailTableViewController.swift
//  MusicVideoPlayer
//
//  Created by Kunal Pachauri on 7/22/16.
//  Copyright © 2016 Kunal Pachauri. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import LocalAuthentication

class DetailTableViewController: UIViewController {
    
    var videos:Videos!
    var security : Bool = false
    
    
    @IBOutlet weak var vNameLabel: UILabel!
    
    @IBOutlet weak var vImageView: UIImageView!
    
    @IBOutlet weak var vGenreLabel: UILabel!

    @IBOutlet weak var vRightsLabel: UILabel!
    
    @IBOutlet weak var vPriceLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NotificationCenter.default.addObserver(self, selector: "preferredFontChanged", name: NSNotification.Name.UIContentSizeCategoryDidChange, object: nil)

        func preferredFontChanged(){
            print("Preferred Font Changed")
        }

       vNameLabel.text=videos .vName
        vGenreLabel.text=videos.vGenre
        vRightsLabel.text=videos.vRights
        vPriceLabel.text=videos.vPrice

        
        if videos.vImageData != nil{
            vImageView.image = UIImage(data: videos.vImageData! as Data)
        }
        else{
            vImageView.image = UIImage(named: "imageNotAvailable")
        }


    }
    
    func touchIdCheck(){
            //Create the Alert
        
        let alert = UIAlertController(title: "", message: "", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "message", style: UIAlertActionStyle.cancel, handler: nil))
        
        
            //Create the local Authentication Context
            let context = LAContext()
            var touchIDError : NSError?
            let reasonString = "Touch ID Authentication is needed to share on social media"
        
        
            //Check if we can authntication with the local biometrics
            if context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error:&touchIDError)
            {
                //Check what the authentication response was
                	context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString, reply: { (success, policyError) -> Void in
                        
                        if success{
                            //User authenticated with local biometrics successfully
                            DispatchQueue.main.async { [unowned self] in
                            self.shareMedia()
                            }
                        }
                        else
                        {
                            
                            alert.title = "Unsuccessful"
                            
                            switch LAError.Code(rawValue: policyError!.code)! {
                            case .appCancel:
                                alert.message = "The Authentication was cancelled by user"
                            case .authenticationFailed:
                                alert.message = "Authentication Failed"
                           
                            case .systemCancel:
                                alert.message = "System Cancelled authentication"
                            default:
                                alert.message = "Local Authentication failed"
                            }
                            DispatchQueue.main.async{ [unowned self] in
                                self.present(alert, animated: true, completion: nil)
                            }
                        }
                    })
                }
        else
            {
                alert.title = "Error"
                
                switch LAError.Code(rawValue: touchIDError!.code)! {
                case .touchIDLockout:
                    alert.message = "TouchID LockedOut"
                case .touchIDNotAvailable:
                    alert.message = "TouchID Not Available"
                case .touchIDNotEnrolled:
                    alert.message = "TouchID Not Enrolled"
                default:
                    alert.message = "Local Authentication Error"
                    
                }
                self.present(alert, animated: true, completion: nil)
                }
        
    }
    
    
    
    
    
    
    
    
    @IBAction func socialMedia(_ sender: AnyObject) {
        
        security = UserDefaults.standard.bool(forKey: "touchID")
        switch security
        {
        case true:
            touchIdCheck()
        default:
            shareMedia()
        }
        
    }
    
    func shareMedia() {
        
        let activity1="Have you had the opportunity to play through this music video?"
        let activity2="\(videos.vName) by \(videos.vArtist)"
        let activity3="Tell me Your feedback!"
        let activity4="\(videos.vLinkToiTunes)"
        let activity5="(Shared through ThePoint9 Music App)"
        
        let activityController : UIActivityViewController = UIActivityViewController(activityItems: [activity1,activity2,activity3,activity4,activity5], applicationActivities: nil)
        
        activityController.completionWithItemsHandler = {(activity,success,items,error ) in
            
            if activity == UIActivityType.postToFacebook{
                print("activity")
            }
            
        }
        
        self.present(activityController, animated: true, completion: nil)
        
    }
    
    @IBAction func playVideo(_ sender: UIBarButtonItem) {
        
        let url = URL(string: videos.vVideoUrl)!
        let player = AVPlayer(url: url)
        let playerViewController = AVPlayerViewController()
        
        playerViewController.player = player
        
        self.present(playerViewController, animated: true){
            playerViewController.player?.play()
            
        }
        
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self, name:NSNotification.Name(rawValue: "preferredFontChanged"), object: nil)
    }

  

}
