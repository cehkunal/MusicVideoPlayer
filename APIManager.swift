//
//  APIManager.swift
//  MusicVideoPlayer
//
//  Created by Kunal Pachauri on 7/16/16.
//  Copyright © 2016 Kunal Pachauri. All rights reserved.
//

import Foundation

class APIManager {
    
    func loadData ( urlstring:String, completion: [Videos]-> Void)
    {
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        
        
        let session = NSURLSession(configuration: config)
        let url = NSURL(string: urlstring)!
        
        
//        let task = session.dataTaskWithURL(url) {
//            (data , response, error ) -> Void in
//            
//            
//            dispatch_async(dispatch_get_main_queue(), { () -> Void in
//               
//                if(error != nil){
//                    completion(result: error!.localizedDescription)
//                }
//                else
//                {
//                    completion(result: "NSURLSESSION SUCCESSFUL")
//                    print(data)
//                }
//                
//             })
//            
//        }
       
        
        let task = session.dataTaskWithURL(url) {
            (data , response , error ) -> Void in
            
            if error != nil {
                    print(error!.localizedDescription)
                }
            else
            {
                do
                {
                    if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                    as? JSONDictionary,
                    feed = json["feed"] as? JSONDictionary ,
                    entries = feed["entry"] as? JSONArray
                        {
                            var videos = [Videos]()
                            for (index,entry) in entries.enumerate()
                            {
                                let entry = Videos(data: entry as! JSONDictionary)
                                entry.vRank = index+1
                                videos.append(entry)
                            }
                            
                            let i = videos.count
                            print("Total number of videos count = \(i)")
                            print("")
                            
                            
                           let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                            dispatch_async(dispatch_get_global_queue(priority, 0)){
                                dispatch_async(dispatch_get_main_queue()){
                                    completion(videos)
                                }
                            }
                    }
                    
                }
                
                catch {
                    dispatch_async(dispatch_get_main_queue()){
                    print("JSONSerialisation Error")
                    }
                    
                    
                }
                
                
            }
        }
        
        task.resume()
        
        }

    
    
}
