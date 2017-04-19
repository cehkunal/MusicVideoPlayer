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
        
        NotificationCenter.default.addObserver(self, selector: #selector(MusicPlayerTVC.reachabilityStatusChanged), name: NSNotification.Name(rawValue: "ReachStatusChanged"), object: nil)
       
         NotificationCenter.default.addObserver(self, selector: #selector(MusicPlayerTVC.preferredFontChanged), name: NSNotification.Name.UIContentSizeCategoryDidChange, object: nil)
        reachabilityStatusChanged()
        
    }
    
    func preferredFontChanged(){
        print("Font Changed")
    }
    
    
    func reachabilityStatusChanged() {
        switch reachabilityStatus {
        case NOACCESS:
            //self.view.backgroundColor=UIColor.redColor()
            DispatchQueue.main.async{
            let alert = UIAlertController(title: "No Access", message: "Make sure you are connected to internet", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                print("OK")
            })
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { (action) -> Void in
                print("CANCEL")
                })
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive , handler: { (action) -> Void in
                print("delete")
            })
            
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            alert.addAction(deleteAction)
            
            self.present(alert, animated: true, completion: nil)
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
    
    
    
    @IBAction func refreshData(_ sender: UIRefreshControl) {
    
        if searchController.isActive{
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
        
        if UserDefaults.standard.object(forKey: "APICNT") != nil{
            let theValue = UserDefaults.standard.object(forKey: "APICNT") as! Int
            limit = theValue
        }
        else
        {
            limit = 10
        }
        print(limit)
       
        
        let formatter = DateFormatter()
        formatter.dateFormat = "E, dd MMM yyyy HH:mm:ss"
        let refreshDate = formatter.string(from: Date())
        
        refreshControl?.attributedTitle = NSAttributedString(string: "\(refreshDate)")
    }
    
    
    func didLoadData(_ videos: [Videos] )
    {
        
        self.videos=videos
        
        for(index , item) in videos.enumerated()
        {
            print("\(index) and title \(item.vName)")
        }
        
        
        //Setup Search Contents
        definesPresentationContext = true
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search By Title ,Artist or Rank"
        searchController.searchBar.searchBarStyle = UISearchBarStyle.prominent
        
        
        
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
        NotificationCenter.default.removeObserver(self, name:NSNotification.Name(rawValue: "reachabilityStatusChanged"), object: nil)
        NotificationCenter.default.removeObserver(self, name:NSNotification.Name(rawValue: "preferredFontChanged"), object: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive{
            return filterVideos.count
        }
        return videos.count
    }

    fileprivate struct storyBoard{
        static let cellReusableIdentifier = "cell"
        static let segueIdentifier = "DetailView"
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: storyBoard.cellReusableIdentifier, for: indexPath) as! MusicVideoPlayerTableViewCell
        
        if searchController.isActive{
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == storyBoard.segueIdentifier{
            if let indexpath = tableView.indexPathForSelectedRow{
                let video : Videos!
                if searchController.isActive{
                    video = filterVideos[indexpath.row]
                }
                else
                {
                    video = videos[indexpath.row]
                }
                
                let dvc = segue.destination as! DetailTableViewController
               dvc.videos = video
            }
        }
    }
    
    
    
    //Creating Search Logic
    func updateSearchResults(for searchController: UISearchController){
        searchController.searchBar.text!.lowercased()
        filterSearch(searchController.searchBar.text!)
    }
    
    
    func filterSearch(_ searchText: String){
        
        filterVideos = videos.filter { videos in
        return videos.vArtist.lowercased().contains(searchText.lowercased()) || videos.vName.lowercased().contains(searchText.lowercased()) || "\(videos.vRank)".lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
        
    }
    
    
    

}
