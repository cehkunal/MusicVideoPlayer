//
//  MusicPlayerTVC.swift
//  MusicVideoPlayer
//
//  Created by Kunal Pachauri on 7/18/16.
//  Copyright © 2016 Kunal Pachauri. All rights reserved.
//

import UIKit

class MusicPlayerTVC: UITableViewController,UISearchResultsUpdating {

    var videos = [Videos]()
    
    var filterVideos = [Videos]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    let imgQuality = false
    
    var limit = 10
    
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
    
    
    
    @IBAction func refreshData(sender: UIRefreshControl) {
    
        if searchController.active{
            refreshControl?.endRefreshing()
            	refreshControl?.attributedTitle = NSAttributedString(string: "No Refresh Allowed in Search")
        }
        else
        {
        refreshControl?.endRefreshing()
        callAPI()
        title = "Top \(limit) itunes Songs"
        }
        
    }
    
    
    
    func getAPICount(){
        
        if NSUserDefaults.standardUserDefaults().objectForKey("APICNT") != nil{
            let theValue = NSUserDefaults.standardUserDefaults().objectForKey("APICNT") as! Int
            limit = theValue
        }
        else
        {
            limit = 10
        }
        print(limit)
       
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "E, dd MMM yyyy HH:mm:ss"
        let refreshDate = formatter.stringFromDate(NSDate())
        
        refreshControl?.attributedTitle = NSAttributedString(string: "\(refreshDate)")
    }
    
    
    func didLoadData(videos: [Videos] )
    {
        
        self.videos=videos
        
        for(index , item) in videos.enumerate()
        {
            print("\(index) and title \(item.vName)")
        }
        
        
        //Setup Search Contents
        definesPresentationContext = true
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search By Title ,Artist or Rank"
        searchController.searchBar.searchBarStyle = UISearchBarStyle.Prominent
        
        
        
        //Add the Search Bar to your Table View
        tableView.tableHeaderView = searchController.searchBar
        
        
        
        tableView.reloadData()
        }

    
    func callAPI(){
        
        getAPICount()
        title = "Top \(limit) itunes Songs"
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=\(limit)/json", completion: didLoadData)
        
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
        if searchController.active{
            return filterVideos.count
        }
        return videos.count
    }

    private struct storyBoard{
        static let cellReusableIdentifier = "cell"
        static let segueIdentifier = "DetailView"
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(storyBoard.cellReusableIdentifier, forIndexPath: indexPath) as! MusicVideoPlayerTableViewCell
        
        if searchController.active{
            cell.video = filterVideos[indexPath.row]
        }
        else
        {
        cell.video=videos[indexPath.row]
        }
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
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == storyBoard.segueIdentifier{
            if let indexpath = tableView.indexPathForSelectedRow{
                let video : Videos!
                if searchController.active{
                    video = filterVideos[indexpath.row]
                }
                else
                {
                    video = videos[indexpath.row]
                }
                
                let dvc = segue.destinationViewController as! DetailTableViewController
               dvc.videos = video
            }
        }
    }
    
    
    
    //Creating Search Logic
    func updateSearchResultsForSearchController(searchController: UISearchController){
        searchController.searchBar.text!.lowercaseString
        filterSearch(searchController.searchBar.text!)
    }
    
    
    func filterSearch(searchText: String){
        
        filterVideos = videos.filter { videos in
        return videos.vArtist.lowercaseString.containsString(searchText.lowercaseString) || videos.vName.lowercaseString.containsString(searchText.lowercaseString) || "\(videos.vRank)".lowercaseString.containsString(searchText.lowercaseString)
        }
        tableView.reloadData()
        
    }
    
    
    

}
