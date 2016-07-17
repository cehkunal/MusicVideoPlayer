//
//  ViewController.swift
//  MusicVideoPlayer
//
//  Created by Kunal Pachauri on 7/14/16.
//  Copyright © 2016 Kunal Pachauri. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var videos = [Videos]()

    @IBOutlet weak var displayLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityStatusChanged", name: "ReachStatusChanged", object: nil)
        
        reachabilityStatusChanged()
        
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json", completion: didLoadData)
        
        
    }
    
    
    func reachabilityStatusChanged() {
        switch reachabilityStatus {
        case NOACCESS: self.view.backgroundColor=UIColor.redColor()
            displayLabel.text="No Internet Access"
        case WIFI: self.view.backgroundColor=UIColor.yellowColor()
            displayLabel.text="WiFi Available"
        case WWAN: self.view.backgroundColor=UIColor.blueColor()
            displayLabel.text="3G Available"
        default:return
            
        }
        
    }
    
    
    func didLoadData(videos: [Videos] )
    {
//        let alert = UIAlertController(title: (result), message: nil, preferredStyle: .Alert)
//        
//        let okAction = UIAlertAction(title: "OK", style: .Default) { action -> Void in
//        }
//         //COde to do some task
//            
//            alert.addAction(okAction)
//            self.presentViewController(alert, animated: true, completion: nil)
//        
        
        self.videos=videos
        
       for(index , item) in videos.enumerate()
       {
        print("\(index) and title \(item.vName)")
        }
        
        
        
        
        
    }
	
  


}

