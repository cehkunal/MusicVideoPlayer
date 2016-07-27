//
//  DetailTableViewController.swift
//  MusicVideoPlayer
//
//  Created by Kunal Pachauri on 7/22/16.
//  Copyright © 2016 Kunal Pachauri. All rights reserved.
//

import UIKit

class DetailTableViewController: UIViewController {
    
    var videos:Videos!
    
    @IBOutlet weak var vNameLabel: UILabel!
    
    @IBOutlet weak var vImageView: UIImageView!
    
    @IBOutlet weak var vGenreLabel: UILabel!

    @IBOutlet weak var vRightsLabel: UILabel!
    
    @IBOutlet weak var vPriceLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "preferredFontChanged", name: UIContentSizeCategoryDidChangeNotification, object: nil)

        func preferredFontChanged(){
            print("Preferred Font Changed")
        }

       vNameLabel.text=videos .vName
        vGenreLabel.text=videos.vGenre
        vRightsLabel.text=videos.vRights
        vPriceLabel.text=videos.vPrice

        
        if videos.vImageData != nil{
            vImageView.image = UIImage(data: videos.vImageData!)
        }
        else{
            vImageView.image = UIImage(named: "imageNotAvailable")
        }


    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self, name:"preferredFontChanged", object: nil)
    }

  

}
