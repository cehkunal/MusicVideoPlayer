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

        
          NSNotificationCenter.defaultCenter().addObserver(self, selector: "preferredFontChanged", name: UIContentSizeCategoryDidChangeNotification, object: nil)
      
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
