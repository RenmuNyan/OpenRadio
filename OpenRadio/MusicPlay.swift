//
//  MusicPlay.swift
//  OpenRadio
//
//  Created by DreamLover on 2016/03/04.
//  Copyright © 2016年 Renmu. All rights reserved.
//

import Foundation
import AFSoundManager

//保留文件，播放模块暂时无法独立类管理
class MusicPlay {
    
//    var mPlayer:AFSoundQueue!
//    
//    func selectChannel(id: Int) {
//        HttpReq().getSong(id) { (music) -> Void in
//            print("点选频道，改变频道")
//            let item = AFSoundItem(streamingURL: NSURL(string: music.songUrl))
//            self.mPlayer.addItem(item)
//            self.mPlayer.playNextItem()
//            MainViewController.ins.changeImg(UIImage(data: NSData(contentsOfURL: NSURL(string: music.albumImg)!)!)!)
//        }
//    }
//    
//    func playMusic() {
//        HttpReq().getSong(0) { (music) -> Void in
//            
//            let item = AFSoundItem(streamingURL: NSURL(string: music.songUrl))
//            self.mPlayer = AFSoundQueue(items: [item])
//            self.mPlayer.playCurrentItem()
//            self.mPlayer.listenFeedbackUpdatesWithBlock({ (item) -> Void in
    //                //TODO...
////                debugPrint("正常获取播放")
//                }, andFinishedBlock: { (item) -> Void in
//                    //TODO...
////                    debugPrint("播放结束")
//            })
//        }
//    }
    
}

//播放模块先采用扩展类处理
extension MainViewController:ChannelSelect {
    
    func selectChannel(id: Int) {
        HttpReq().getSong(id) { (music) -> Void in
            print("点选频道，改变频道")
            
            self.titleLabel.text  = NSString(string: music.songTitle) as String
            self.artistLabel.text = NSString(string: music.artist) as String
            self.songKbsLabel = NSString(string: music.songKbps) as String
            self.albumTitle = NSString(string: music.albumTitle)as String
            
            let item = AFSoundItem(streamingURL: NSURL(string: music.songUrl))
            self.mPlayer.addItem(item)
            self.mPlayer.playNextItem()
            self.changeImg(UIImage(data: NSData(contentsOfURL: NSURL(string: music.albumImg)!)!)!)
        }
    }
    
    func playMusic() {
        HttpReq().getSong(1) { (music) -> Void in
            
            self.titleLabel.text  = NSString(string: music.songTitle) as String
            self.artistLabel.text = NSString(string: music.artist) as String
            self.songKbsLabel = NSString(string: music.songKbps) as String
            self.albumTitle = NSString(string: music.albumTitle)as String
            
            self.albumImgView.resumeRoatating()
            self.needleView.needleAntiWiseRoatating()
            
            self.pauseBtn.setImage(UIImage(named: "cm2_btn_pause"), forState: UIControlState.Normal)
            self.pauseBtn.setImage(UIImage(named: "cm2_btn_pause_prs"), forState: UIControlState.Highlighted)
            
            self.changeImg(UIImage(data: NSData(contentsOfURL: NSURL(string: music.albumImg)!)!)!)
            
            
            let item = AFSoundItem(streamingURL: NSURL(string: music.songUrl))
            self.mPlayer = AFSoundQueue(items: [item])
            self.mPlayer.playCurrentItem()
            self.mPlayer.listenFeedbackUpdatesWithBlock({ (item) -> Void in
                //                debugPrint("正常获取播放")
                }, andFinishedBlock: { (item) -> Void in
                    //                    debugPrint("播放结束")
            })
        }
    }
}


