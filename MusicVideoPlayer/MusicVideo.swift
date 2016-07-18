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
    var vImageData : NSData?
    
    var vRank = 0
    
    //Data Encapsulation
    
    private var _vName:String
    private var _vImageUrl: String
    private var _vVideoUrl :String
    private var _vRights:String
    private var _vPrice:String
    private var _vArtist:String
    private var _vImid:String
    private var _vGenre:String
    private var _vLinkToiTunes:String
    private var _vReleaseDate:String
    
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
            vName = name["label"] as? String{
                self._vName=vName
        }
        else
        {
            self._vName=""
        }
        
        
        //Video Image
        if let img = data["im:image"] as? JSONArray,
        image = img[2] as? JSONDictionary ,
            immage = image["label"] as? String {
                _vImageUrl=immage.stringByReplacingOccurrencesOfString("100*100", withString: "600*600" )
        }
        else
        {
            _vImageUrl=""
        }
        
        
        
        //Video Url
        if let video = data["link"] as? JSONArray ,
        vUrl = video[1] as? JSONDictionary ,
        vHref = vUrl["attributes"] as? JSONDictionary ,
        vVideoUrl = vHref["href"] as? String
        {
            self._vVideoUrl = vVideoUrl
        }
        else
        {
            _vVideoUrl=""
        }
        
        
        //Video Rights
        if let rights = data["rights"] as? JSONDictionary ,
            vRights=rights["label"] as? String{
                self._vRights=vRights
        }
        else
        {
            _vRights=""
        }
        
        
        
        //Video Price
        if let price = data["im:price"] as? JSONDictionary ,
        vPrice = price["label"] as? String
        {
            self._vPrice=vPrice
        }
        else
        {
            _vPrice=""
        }
        
        
        //Video Artist
        if let artist = data["im:artist"] as? JSONDictionary ,
            vArtist = artist["label"] as? String{
                self._vArtist=vArtist
        }
        else
        {
            _vArtist=""
        }
        
        
        //Video IMID
        if let id = data["category"] as? JSONDictionary ,
               attributes = id["attributes"] as? JSONDictionary ,
              vImid = attributes["label"] as? String{
                    self._vImid=vImid
        }
        else
        {
            _vImid=""
        }
        
        
        
        //Video Genre
        if let id = data["category"] as? JSONDictionary ,
            attributes = id["attributes"] as? JSONDictionary ,
            vGenre = attributes["term"] as? String{
                self._vGenre=vGenre
        }
        else
        {
            _vGenre=""
        }
        
        
        
        //Video Link To iTunes
        if let id = data["id"] as? JSONDictionary ,
            vLinkToiTunes=id["label"] as? String{
                self._vLinkToiTunes=vLinkToiTunes
        }
        else
        {
            _vLinkToiTunes=""
        }
        
        
        
        
        //Video Release Date
        if let date = data["im:releaseDate"] as? JSONDictionary,
            vReleaseDate = date["label"] as? String{
                self._vReleaseDate=vReleaseDate
        }
        else
        {
            _vReleaseDate=""
        }
        
    }
    
    
    
    
    
    
    
}