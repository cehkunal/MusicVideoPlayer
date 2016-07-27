//
//  SettingsTableViewController.swift
//  MusicVideoPlayer
//
//  Created by Kunal Pachauri on 7/27/16.
//  Copyright © 2016 Kunal Pachauri. All rights reserved.
//

import UIKit
import MessageUI

class SettingsTableViewController: UITableViewController,MFMailComposeViewControllerDelegate {

    
    @IBOutlet weak var aboutLabel: UILabel!
    
    @IBOutlet weak var feedBackLabel: UILabel!
    
    @IBOutlet weak var imageQualityLabel: UILabel!
    
    @IBOutlet weak var securityLabel: UILabel!
    
    @IBOutlet weak var apiCount: UILabel!
    
    @IBOutlet weak var sliderCount: UISlider!
    
    @IBOutlet weak var touchIDSwitch: UISwitch!
    
    @IBOutlet weak var imageQualiySwitch: UISwitch!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Settings"
        
        tableView.alwaysBounceVertical = false
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "preferredFontChanged", name: UIContentSizeCategoryDidChangeNotification, object: nil)
        
        imageQualiySwitch.on = NSUserDefaults.standardUserDefaults().boolForKey("imageQualitySettings")
        touchIDSwitch.on = NSUserDefaults.standardUserDefaults().boolForKey("touchID")
        
        
        if (NSUserDefaults.standardUserDefaults().objectForKey("APICNT")) != nil{
            
            let theValue = NSUserDefaults.standardUserDefaults().objectForKey("APICNT")
             as! Int
            apiCount.text = ("\(theValue)")
            sliderCount.value = Float(theValue)
        }
        else{
            sliderCount.value = 10.0
            apiCount.text = "\(sliderCount.value)"
        }
    }
    
    @IBAction func fetchValueChanged(sender: AnyObject) {
        
        let theValue = NSUserDefaults.standardUserDefaults()
        
        theValue.setObject(Int(sliderCount.value), forKey: "APICNT")
        apiCount.text = ("\(Int(sliderCount.value))")

        
    }
    
    @IBAction func touchIDChanged(sender: UISwitch) {
        let defaults = NSUserDefaults.standardUserDefaults()
        if touchIDSwitch.on{
            defaults.setBool(touchIDSwitch.on, forKey: "touchID")
        }
            
        else{
            defaults.setBool(false, forKey: "touchID")
        }

        
    }
    
    
    
    @IBAction func touchedImageQuality(sender: UISwitch) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if imageQualiySwitch.on{
            defaults.setBool(imageQualiySwitch.on, forKey: "imageQualitySettings")
        }
            
        else{
                defaults.setBool(false, forKey: "imageQualitySettings")
            }
        
    }
    
    
    
    
    func preferredFontChanged() {
        
        aboutLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        
        feedBackLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        
        imageQualityLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        
        securityLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        
        apiCount.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
    }
    
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        if ( indexPath.section == 0 && indexPath.row == 1){
            
            let messageComposeViewController = configureMail()
            
            if MFMailComposeViewController.canSendMail(){
                self.presentViewController(messageComposeViewController, animated: true, completion: nil)
            }
            else
            {
                mailAlert()
            }
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    func mailAlert() {
        
        let mailALert : UIAlertController = UIAlertController(title: "Alert", message: "No e-mail setup for any account", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        
        mailALert.addAction(okAction)
        self.presentViewController(mailALert, animated: true, completion: nil)
    }
    
    
    
    func configureMail() -> MFMailComposeViewController{
        
        let messageComposeVC = MFMailComposeViewController()
        messageComposeVC.mailComposeDelegate = self
        messageComposeVC.setToRecipients(["cehkunal@gmail.com"])
        messageComposeVC.setSubject("Feedback for ThePoint9 Music Video App")
        messageComposeVC.setMessageBody("Hello Kunal! I would like to  share my feedback  . \n", isHTML: false)
        
        
        return messageComposeVC
    }
    
    
   func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?){
    
        switch result.rawValue
        {
        case MFMailComposeResultSaved.rawValue:
                print("Saved")
        case MFMailComposeResultSent.rawValue:
            print("Sent")
        case MFMailComposeResultFailed.rawValue:
            print("failed")
        case MFMailComposeResultCancelled.rawValue:
            print("Cancelled")
        default:
            print("Unknown Issue")
    }
    self.dismissViewControllerAnimated(true, completion: nil)	    
    
    }
    
    
    
    
    
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "preferredFontChanged", object: nil)
}

  
}
