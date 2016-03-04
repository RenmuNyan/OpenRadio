//
//  HttpReq.swift
//  OpenRadio
//
//  Created by DreamLover on 2016/02/28.
//  Copyright © 2016年 Renmu. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

//MARK: - 数据来源结构体定义(DATASOURCE_init)
struct doubanInfo {
    static let SERVER   = "http://www.douban.fm/j/"
    static let CHANNEL  = "app/radio/channels"
    static let PLAYLIST = "mine/playlist"
}

//struct luoInfo {
//    static let SERVER = "http://luoo-mp3.kssws.ks-cdn.com/low/luoo/"
//    static let RADIO  = "radio"
//    static let SUFFIX = ".mp3"
//}

//MARK: - 频道设置类(channelSetting)
class Channel:NSObject {
    var seq_id:Int!
    var name_cn:String?
    var channel_id:Int!
    
    init(chanID:Int, nameCN:String, seqID:Int) {
        self.channel_id = chanID
        self.name_cn    = nameCN
        self.seq_id     = seqID
    }
}

//MARK: - 音乐获取类(musicRequest)
class Music:NSObject {
    var albumImg:String!
    var songTitle:String!
    var songUrl:String!
    var artist:String!
    var albumTitle:String!
    var song_kbps:String!
    
    init(albumImg:String, songTitle:String, songUrl:String, artist:String, albumTitle:String) {
        self.albumImg   = albumImg
        self.songTitle  = songTitle
        self.songUrl    = songUrl
        self.artist     = artist
        self.albumTitle = albumTitle
    }
}

//MARK: - 网络请求类(NetworkRequest)
class HttpReq {
    
    //MARK: - 通过AF请求数据(use_alamofire)
    private func getRequest(a_url: String, parameters: [String: AnyObject]?, completionHandler: ( NSData?, NSError?) -> Void){
        Alamofire.request(.GET, doubanInfo.SERVER + a_url, parameters: parameters, encoding: ParameterEncoding.URL).response { (req, _, data, error) -> Void in
            completionHandler(data, error)
        }
    }
    
    //MARK: - 获取频道信息(channel_info_getting)
    func getChan(completionHandler: (channel:[Channel]) -> Void) {
        self.getRequest(doubanInfo.CHANNEL, parameters: nil) { (data, err) -> Void in
            if err == nil {
                let json = JSON(data: data! as NSData)
                let c_Json = json["channels"]
                var c_Array = [Channel]()
                
                for i in 1..<c_Json.count {
                    let channel_id  = c_Json[i]["channel_id"]
                    let name        = c_Json[i]["name"]
                    let seq_id      = c_Json[i]["seq_id"]
                    
                    let channel = Channel(chanID: channel_id.intValue, nameCN: name.string!, seqID: seq_id.intValue)
                    c_Array.append(channel)
                }
                
                completionHandler(channel: c_Array)

            }else {     //无法获取频道列表错误处理
//                debugPrint(err)
                LoadAnimationView().netErrAni()
            }
        }
    }
    
    //MARK: - 获取歌曲信息(song_info_getting)
    func getSong(chanID:Int, completionHandler: (music: Music) -> Void) {
        self.getRequest(doubanInfo.PLAYLIST, parameters:["channel":chanID]) { (data, err) -> Void in
            if err == nil {
                let json = JSON(data: data! as NSData)
                let s_json = json["song"][0]
                
                if s_json["url"] != nil {
                    let albumImg    = s_json["picture"].string
                    let albumTitle  = s_json["albumtitle"].string
                    let songTitle   = s_json["title"].string
                    let songUrl     = s_json["url"].string
                    let artist      = s_json["artist"].string
                    
                    let songInfo = Music(albumImg: albumImg!, songTitle: songTitle!, songUrl: songUrl!, artist: artist!, albumTitle: albumTitle!)
                    completionHandler(music:songInfo)
                }
                
            }else {     //音频不存在错误处理
                LoadAnimationView().musicErrAni()
            }
        }
    }
}
