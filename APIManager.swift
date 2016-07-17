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
                dispatch_async(dispatch_get_main_queue()){
                    completion(result: error!.localizedDescription)
                }
            }
            else
            {
                do
                {
                    if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                    as? JSONDictionary
                        {
                            print(json)
                            
                           let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                            dispatch_async(dispatch_get_global_queue(priority, 0)){
                                dispatch_async(dispatch_get_main_queue()){
                                    completion(result: "JSON Serialisation Successful")
                                }
                            }
                    }
                    
                }
                
                catch {
                    dispatch_async(dispatch_get_main_queue()){
                    completion(result:"JSON Serialisation Not Successful")
                    }
                    
                    
                }
                
                
            }
        }
        
        task.resume()
        
        }

    
    
}
