//
//  MusicVideoPlayerTableViewCell.swift
//  MusicVideoPlayer
//
//  Created by Kunal Pachauri on 7/18/16.
//  Copyright © 2016 Kunal Pachauri. All rights reserved.
//

import UIKit

class MusicVideoPlayerTableViewCell: UITableViewCell {

    var video : Videos? {
        didSet{
            updateCell()
        }
    }
    
    @IBOutlet weak var musicImage: UIImageView!
    
    @IBOutlet weak var rankLabel: UILabel!
    
    @IBOutlet weak var musicTitleLabel: UILabel!
    
    func updateCell(){
        
        rankLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        
        musicTitleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        
        
        rankLabel.text = "\(video!.vRank)"
        musicTitleLabel.text = video?.vName
        //musicImage.image = UIImage(named: "imageNotAvailable")
        
        if video?.vImageData != nil{
            print("Get Data from array")
            musicImage.image = UIImage(data: video!.vImageData!)
        }
        else
        {
            getVideoImage(video!, imageview: musicImage)
        }
        
        
        
        
        
    }
    
    
    
    func getVideoImage(video:Videos , imageview:UIImageView){
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
            
            let data = NSData(contentsOfURL: NSURL(string:video.vImageUrl)!)
            
            var image : UIImage?
            
            if data != nil {
                video.vImageData = data
                image = UIImage(data: data!)
            }
            
            dispatch_async(dispatch_get_main_queue()){
                imageview.image = image
            }
            
            
        }
        
        
    }
    
    
    
}
