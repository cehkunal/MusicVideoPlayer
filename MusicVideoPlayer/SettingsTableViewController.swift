//
//  SettingsTableViewController.swift
//  MusicVideoPlayer
//
//  Created by Kunal Pachauri on 7/27/16.
//  Copyright © 2016 Kunal Pachauri. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    
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
    
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "preferredFontChanged", object: nil)
}

  
}
