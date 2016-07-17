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

    override func viewDidLoad() {
        super.viewDidLoad()

        print(reachabilityStatus)
        
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json", completion: didLoadData)
        
        
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

