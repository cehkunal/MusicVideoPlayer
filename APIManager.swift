//
//  APIManager.swift
//  MusicVideoPlayer
//
//  Created by Kunal Pachauri on 7/16/16.
//  Copyright © 2016 Kunal Pachauri. All rights reserved.
//

import Foundation

class APIManager {
    
    func loadData ( _ urlstring:String, completion: @escaping ([Videos])-> Void)
    {
        let config = URLSessionConfiguration.ephemeral
        
        
        let session = URLSession(configuration: config)
        let url = URL(string: urlstring)!
        
        
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
       
        
        let task = session.dataTask(with: url, completionHandler: {
            (data , response , error ) -> Void in
            
            if error != nil {
                    print(error!.localizedDescription)
                }
            else
            {
                do
                {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                    as? JSONDictionary,
                    let feed = json["feed"] as? JSONDictionary ,
                    let entries = feed["entry"] as? JSONArray
                        {
                            var videos = [Videos]()
                            for (index,entry) in entries.enumerated()
                            {
                                let entry = Videos(data: entry as! JSONDictionary)
                                entry.vRank = index+1
                                videos.append(entry)
                            }
                            
                            let i = videos.count
                            print("Total number of videos count = \(i)")
                            print("")
                            
                            
                           let priority = DispatchQueue.GlobalQueuePriority.high
                            DispatchQueue.global(priority: priority).async{
                                DispatchQueue.main.async{
                                    completion(videos)
                                }
                            }
                    }
                    
                }
                
                catch {
                    DispatchQueue.main.async{
                    print("JSONSerialisation Error")
                    }
                    
                    
                }
                
                
            }
        }) 
        
        task.resume()
        
        }

    
    
}
