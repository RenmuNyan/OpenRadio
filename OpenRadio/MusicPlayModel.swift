//
//  MusicPlayModel.swift
//  OpenRadio
//
//  Created by DreamLover on 2016/03/02.
//  Copyright © 2016年 Renmu. All rights reserved.
//

import UIKit
import AFSoundManager

class MusicPlayModel:ChannelSelect{
    
    var mPlayer:AFSoundQueue?
    
    func getMusic() {
        HttpReq().getSong(0) { (music) -> Void in
            let item = AFSoundItem(streamingURL: NSURL(string: music.songUrl))
            self.mPlayer = AFSoundQueue(items: [item])
            self.mPlayer!.playCurrentItem()
            self.mPlayer!.listenFeedbackUpdatesWithBlock({ (item) -> Void in
                //TODO...
                //                debugPrint("正常获取播放")
                }, andFinishedBlock: { (item) -> Void in
                    //TODO...
                    //                    debugPrint("播放结束")
            })
        }
    }
    
    func selectChan(channel_id: Int) {
        HttpReq().getSong(channel_id) { (music) -> Void in
            print("点选频道，改变频道")
            
            let item = AFSoundItem(streamingURL: NSURL(string: music.songUrl))
            self.mPlayer!.addItem(item)
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
                self.mPlayer!.playNextItem()
            })
            MainViewController().changeImg(UIImage(data: NSData(contentsOfURL: NSURL(string: music.albumImg)!)!)!)
        }
    }
}