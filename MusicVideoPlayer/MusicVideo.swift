//
//  MusicVideo.swift
//  MusicVideoPlayer
//
//  Created by Kunal Pachauri on 7/17/16.
//  Copyright © 2016 Kunal Pachauri. All rights reserved.
//

import Foundation

class Videos
{
    var vImageData : Data?
    
    var vRank = 0
    
    //Data Encapsulation
    
    fileprivate var _vName:String
    fileprivate var _vImageUrl: String
    fileprivate var _vVideoUrl :String
    fileprivate var _vRights:String
    fileprivate var _vPrice:String
    fileprivate var _vArtist:String
    fileprivate var _vImid:String
    fileprivate var _vGenre:String
    fileprivate var _vLinkToiTunes:String
    fileprivate var _vReleaseDate:String
    
    //make getters
    var vName:String{
        return _vName
    }
    
    var vImageUrl:String{
        return _vImageUrl
    }
    
    var vVideoUrl:String{
        return _vVideoUrl
    }
    
    var vRights:String{
        return _vRights
    }
    
    var vPrice:String{
        return _vPrice
    }
    
    var vArtist:String{
        return _vArtist
    }
    
    var vImid:String{
        return _vImid
    }
    
    var vGenre:String{
        return _vGenre
    }
    
    var vLinkToiTunes:String{
        return _vLinkToiTunes
    }
    
    var vReleaseDate:String{
        return _vReleaseDate
    }
    
    
    init(data: JSONDictionary)
    {
        //Video Name
        if let name = data["im:name"] as? JSONDictionary ,
            let vName = name["label"] as? String{
                self._vName=vName
        }
        else
        {
            self._vName=""
        }
        
        
        //Video Image
        if let img = data["im:image"] as? JSONArray,
        let image = img[2] as? JSONDictionary ,
            let immage = image["label"] as? String {
                _vImageUrl=immage.replacingOccurrences(of: "100*100", with: "1200*1200" )
        }
        else
        {
            _vImageUrl=""
        }
        
        
        
        //Video Url
        if let video = data["link"] as? JSONArray ,
        let vUrl = video[1] as? JSONDictionary ,
        let vHref = vUrl["attributes"] as? JSONDictionary ,
        let vVideoUrl = vHref["href"] as? String
        {
            self._vVideoUrl = vVideoUrl
        }
        else
        {
            _vVideoUrl=""
        }
        
        
        //Video Rights
        if let rights = data["rights"] as? JSONDictionary ,
            let vRights=rights["label"] as? String{
                self._vRights=vRights
        }
        else
        {
            _vRights=""
        }
        
        
        
        //Video Price
        if let price = data["im:price"] as? JSONDictionary ,
        let vPrice = price["label"] as? String
        {
            self._vPrice=vPrice
        }
        else
        {
            _vPrice=""
        }
        
        
        //Video Artist
        if let artist = data["im:artist"] as? JSONDictionary ,
            let vArtist = artist["label"] as? String{
                self._vArtist=vArtist
        }
        else
        {
            _vArtist=""
        }
        
        
        //Video IMID
        if let id = data["category"] as? JSONDictionary ,
               let attributes = id["attributes"] as? JSONDictionary ,
              let vImid = attributes["label"] as? String{
                    self._vImid=vImid
        }
        else
        {
            _vImid=""
        }
        
        
        
        //Video Genre
        if let id = data["category"] as? JSONDictionary ,
            let attributes = id["attributes"] as? JSONDictionary ,
            let vGenre = attributes["term"] as? String{
                self._vGenre=vGenre
        }
        else
        {
            _vGenre=""
        }
        
        
        
        //Video Link To iTunes
        if let id = data["id"] as? JSONDictionary ,
            let vLinkToiTunes=id["label"] as? String{
                self._vLinkToiTunes=vLinkToiTunes
        }
        else
        {
            _vLinkToiTunes=""
        }
        
        
        
        
        //Video Release Date
        if let date = data["im:releaseDate"] as? JSONDictionary,
            let vReleaseDate = date["label"] as? String{
                self._vReleaseDate=vReleaseDate
        }
        else
        {
            _vReleaseDate=""
        }
        
    }
    
    
    
    
    
    
    
}
