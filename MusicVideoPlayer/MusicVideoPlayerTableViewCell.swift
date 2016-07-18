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
        
        rankLabel.text = "\(video!.vRank)"
        musicTitleLabel.text = video?.vName
        musicImage.image = UIImage(named: "imageNotAvailable")
        
    }
    
}
