//
//  APIManager.swift
//  MusicVideoPlayer
//
//  Created by Kunal Pachauri on 7/16/16.
//  Copyright © 2016 Kunal Pachauri. All rights reserved.
//

import Foundation

class APIManager {
    
    func loadData ( urlstring:String, completion: (result:String)-> Void)
    {
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        
        
        let session = NSURLSession(configuration: config)
        let url = NSURL(string: urlstring)!
        
        
        let task = session.dataTaskWithURL(url) {
            (data , response, error ) -> Void in
            
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
               
                if(error != nil){
                    completion(result: error!.localizedDescription)
                }
                else
                {
                    completion(result: "NSURLSESSION SUCCESSFUL")
                    print(data)
                }
                
             })
            
        }
        task.resume()
        
        
        }

    
    
}
