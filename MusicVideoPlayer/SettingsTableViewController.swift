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
        
        NotificationCenter.default.addObserver(self, selector: #selector(SettingsTableViewController.preferredFontChanged), name: NSNotification.Name.UIContentSizeCategoryDidChange, object: nil)
        
        imageQualiySwitch.isOn = UserDefaults.standard.bool(forKey: "imageQualitySettings")
        touchIDSwitch.isOn = UserDefaults.standard.bool(forKey: "touchID")
        
        
        if (UserDefaults.standard.object(forKey: "APICNT")) != nil{
            
            let theValue = UserDefaults.standard.object(forKey: "APICNT")
             as! Int
            apiCount.text = ("\(theValue)")
            sliderCount.value = Float(theValue)
        }
        else{
            sliderCount.value = 10.0
            apiCount.text = "\(sliderCount.value)"
        }
    }
    
    @IBAction func fetchValueChanged(_ sender: AnyObject) {
        
        let theValue = UserDefaults.standard
        
        theValue.set(Int(sliderCount.value), forKey: "APICNT")
        apiCount.text = ("\(Int(sliderCount.value))")

        
    }
    
    @IBAction func touchIDChanged(_ sender: UISwitch) {
        let defaults = UserDefaults.standard
        if touchIDSwitch.isOn{
            defaults.set(touchIDSwitch.isOn, forKey: "touchID")
        }
            
        else{
            defaults.set(false, forKey: "touchID")
        }

        
    }
    
    
    
    @IBAction func touchedImageQuality(_ sender: UISwitch) {
        
        let defaults = UserDefaults.standard
        if imageQualiySwitch.isOn{
            defaults.set(imageQualiySwitch.isOn, forKey: "imageQualitySettings")
        }
            
        else{
                defaults.set(false, forKey: "imageQualitySettings")
            }
        
    }
    
    
    
    
    func preferredFontChanged() {
        
        aboutLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        
        feedBackLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        
        imageQualityLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        
        securityLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        
        apiCount.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
    }
    
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if ( indexPath.section == 0 && indexPath.row == 1){
            
            let messageComposeViewController = configureMail()
            
            if MFMailComposeViewController.canSendMail(){
                self.present(messageComposeViewController, animated: true, completion: nil)
            }
            else
            {
                mailAlert()
            }
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    func mailAlert() {
        
        let mailALert : UIAlertController = UIAlertController(title: "Alert", message: "No e-mail setup for any account", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        mailALert.addAction(okAction)
        self.present(mailALert, animated: true, completion: nil)
    }
    
    
    
    func configureMail() -> MFMailComposeViewController{
        
        let messageComposeVC = MFMailComposeViewController()
        messageComposeVC.mailComposeDelegate = self
        messageComposeVC.setToRecipients(["cehkunal@gmail.com"])
        messageComposeVC.setSubject("Feedback for ThePoint9 Music Video App")
        messageComposeVC.setMessageBody("Hello Kunal! I would like to  share my feedback  . \n", isHTML: false)
        
        
        return messageComposeVC
    }
    
    
   func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?){
    
        switch result.rawValue
        {
        case MFMailComposeResult.saved.rawValue:
                print("Saved")
        case MFMailComposeResult.sent.rawValue:
            print("Sent")
        case MFMailComposeResult.failed.rawValue:
            print("failed")
        case MFMailComposeResult.cancelled.rawValue:
            print("Cancelled")
        default:
            print("Unknown Issue")
    }
    self.dismiss(animated: true, completion: nil)	    
    
    }
    
    
    
    
    
    
    deinit{
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "preferredFontChanged"), object: nil)
}

  
}
