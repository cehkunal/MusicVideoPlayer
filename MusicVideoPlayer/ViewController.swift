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
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.reachabilityStatusChanged), name: NSNotification.Name(rawValue: "ReachStatusChanged"), object: nil)
        
        reachabilityStatusChanged()
        
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=200/json", completion: didLoadData)
        
    }
    
    
    func reachabilityStatusChanged() {
        switch reachabilityStatus {
        case NOACCESS: self.view.backgroundColor=UIColor.red
            displayLabel.text="No Internet Access"
        case WIFI: self.view.backgroundColor=UIColor.yellow
            displayLabel.text="WiFi Available"
        case WWAN: self.view.backgroundColor=UIColor.blue
            displayLabel.text="3G Available"
        default:return
            
        }
        
    }
    
    
    func didLoadData(_ videos: [Videos] )
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
        
       for(index , item) in videos.enumerated()
       {
        print("\(index) and title \(item.vName)")
        }
        
        tableView.reloadData()
        

        
        
        
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
	
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let video=videos[indexPath.row]
        
        cell.textLabel?.text = ("\(indexPath.row + 1)")
        cell.detailTextLabel?.text = video.vName
    
    return cell
    }
  


}

