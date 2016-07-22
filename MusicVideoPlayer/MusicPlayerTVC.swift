//
//  MusicPlayerTVC.swift
//  MusicVideoPlayer
//
//  Created by Kunal Pachauri on 7/18/16.
//  Copyright © 2016 Kunal Pachauri. All rights reserved.
//

import UIKit

class MusicPlayerTVC: UITableViewController {

    var videos = [Videos]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityStatusChanged", name: "ReachStatusChanged", object: nil)
       
         NSNotificationCenter.defaultCenter().addObserver(self, selector: "preferredFontChanged", name: UIContentSizeCategoryDidChangeNotification, object: nil)
        reachabilityStatusChanged()
        
        
    }
    
    func preferredFontChanged(){
        print("Font Changed")
    }
    
    
    func reachabilityStatusChanged() {
        switch reachabilityStatus {
        case NOACCESS:
            //self.view.backgroundColor=UIColor.redColor()
            dispatch_async(dispatch_get_main_queue()){
            let alert = UIAlertController(title: "No Access", message: "Make sure you are connected to internet", preferredStyle: .Alert)
            
            let okAction = UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
                print("OK")
            })
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Default, handler: { (action) -> Void in
                print("CANCEL")
                })
            
            let deleteAction = UIAlertAction(title: "Delete", style: .Destructive , handler: { (action) -> Void in
                print("delete")
            })
            
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            alert.addAction(deleteAction)
            
            self.presentViewController(alert, animated: true, completion: nil)
            }
            
        default:
            //self.view.backgroundColor = UIColor.greenColor()
            if videos.count > 0
            {
                print("do not refresh")
            }else
            {
            callAPI()
            }
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

    
    func callAPI(){
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=50/json", completion: didLoadData)
        
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self, name:"reachabilityStatusChanged", object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name:"preferredFontChanged", object: nil)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return videos.count
    }

    private struct storyBoard{
        static let cellReusableIdentifier = "cell"
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(storyBoard.cellReusableIdentifier, forIndexPath: indexPath) as! MusicVideoPlayerTableViewCell
        

        cell.video=videos[indexPath.row]

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
