//
//  ViewController.swift
//  MusicVideoPlayer
//
//  Created by Kunal Pachauri on 7/14/16.
//  Copyright © 2016 Kunal Pachauri. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDataSource , UITableViewDelegate {
    
    var videos = [Videos]()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var displayLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityStatusChanged", name: "ReachStatusChanged", object: nil)
        
        reachabilityStatusChanged()
        
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=200/json", completion: didLoadData)
        
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
        
        tableView.reloadData()
        

        
        
        
        
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
	
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        let video=videos[indexPath.row]
        
        cell.textLabel?.text = ("\(indexPath.row + 1)")
        cell.detailTextLabel?.text = video.vName
    
    return cell
    }
  


}

