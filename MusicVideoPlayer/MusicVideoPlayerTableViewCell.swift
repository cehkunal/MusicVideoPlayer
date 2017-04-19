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
        
        rankLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        
        musicTitleLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        
        
        rankLabel.text = "\(video!.vRank)"
        musicTitleLabel.text = video?.vName
        //musicImage.image = UIImage(named: "imageNotAvailable")
        
        if video?.vImageData != nil{
            print("Get Data from array")
            musicImage.image = UIImage(data: video!.vImageData! as Data)
        }
        else
        {
            getVideoImage(video!, imageview: musicImage)
        }
        
        
        
        
        
    }
    
    
    
    func getVideoImage(_ video:Videos , imageview:UIImageView){
        
        DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async{
            
            let data = try? Data(contentsOf: URL(string:video.vImageUrl)!)
            
            var image : UIImage?
            
            if data != nil {
                video.vImageData = data as! NSData as Data
                image = UIImage(data: data!)
            }
            
            DispatchQueue.main.async{
                imageview.image = image
            }
            
            
        }
        
        
    }
    
    
    
}
