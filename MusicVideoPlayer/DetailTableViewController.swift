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
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "preferredFontChanged", name: UIContentSizeCategoryDidChangeNotification, object: nil)

        func preferredFontChanged(){
            print("Preferred Font Changed")
        }

       vNameLabel.text=videos .vName
        vGenreLabel.text=videos.vGenre
        vRightsLabel.text=videos.vRights
        vPriceLabel.text=videos.vPrice

        
        if videos.vImageData != nil{
            vImageView.image = UIImage(data: videos.vImageData!)
        }
        else{
            vImageView.image = UIImage(named: "imageNotAvailable")
        }


    }
    
    func touchIdCheck(){
            //Create the Alert
        
        let alert = UIAlertController(title: "", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "message", style: UIAlertActionStyle.Cancel, handler: nil))
        
        
            //Create the local Authentication Context
            let context = LAContext()
            var touchIDError : NSError?
            let reasonString = "Touch ID Authentication is needed to share on social media"
        
        
            //Check if we can authntication with the local biometrics
            if context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error:&touchIDError)
            {
                //Check what the authentication response was
                	context.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString, reply: { (success, policyError) -> Void in
                        
                        if success{
                            //User authenticated with local biometrics successfully
                            dispatch_async(dispatch_get_main_queue()) { [unowned self] in
                            self.shareMedia()
                            }
                        }
                        else
                        {
                            
                            alert.title = "Unsuccessful"
                            
                            switch LAError(rawValue: policyError!.code)! {
                            case .AppCancel:
                                alert.message = "The Authentication was cancelled by user"
                            case .AuthenticationFailed:
                                alert.message = "Authentication Failed"
                           
                            case .SystemCancel:
                                alert.message = "System Cancelled authentication"
                            default:
                                alert.message = "Local Authentication failed"
                            }
                            dispatch_async(dispatch_get_main_queue()){ [unowned self] in
                                self.presentViewController(alert, animated: true, completion: nil)
                            }
                        }
                    })
                }
        else
            {
                alert.title = "Error"
                
                switch LAError(rawValue: touchIDError!.code)! {
                case .TouchIDLockout:
                    alert.message = "TouchID LockedOut"
                case .TouchIDNotAvailable:
                    alert.message = "TouchID Not Available"
                case .TouchIDNotEnrolled:
                    alert.message = "TouchID Not Enrolled"
                default:
                    alert.message = "Local Authentication Error"
                    
                }
                self.presentViewController(alert, animated: true, completion: nil)
                }
        
    }
    
    
    
    
    
    
    
    
    @IBAction func socialMedia(sender: AnyObject) {
        
        security = NSUserDefaults.standardUserDefaults().boolForKey("touchID")
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
            
            if activity == UIActivityTypePostToFacebook{
                print("activity")
            }
            
        }
        
        self.presentViewController(activityController, animated: true, completion: nil)
        
    }
    
    @IBAction func playVideo(sender: UIBarButtonItem) {
        
        let url = NSURL(string: videos.vVideoUrl)!
        let player = AVPlayer(URL: url)
        let playerViewController = AVPlayerViewController()
        
        playerViewController.player = player
        
        self.presentViewController(playerViewController, animated: true){
            playerViewController.player?.play()
            
        }
        
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self, name:"preferredFontChanged", object: nil)
    }

  

}
