//
//  ViewController.swift
//  OpenRadio
//
//  Created by DreamLover on 2016/01/26.
//  Copyright © 2016年 Renmu. All rights reserved.
//

import UIKit
import AFSoundManager

class MainViewController: UIViewController {
    
    //MARK: - 定义、初始化(Init, Prepare)
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    
    @IBOutlet weak var pauseBtn: UIButton!
    @IBOutlet weak var replayBtn: UIButton!
    
    @IBOutlet weak var albumImgView: AlbumImageView!
    @IBOutlet weak var backImageView: BGImageView!
    @IBOutlet weak var needleView: NeedleView!
    
    var roaDesuka:Bool = false
    var repDesuka:Bool = false
    
    var mPlayer:AFSoundQueue!
    var songKbsLabel:String!
    var albumTitle:String!
    
    //MARK: - 全局(Global)
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let gesture = UISwipeGestureRecognizer(target: self, action: "toggleRightDrawer:")
        gesture.direction = .Left
        self.view.addGestureRecognizer(gesture)
        
        albumImgView.startRoatating()
        albumImgView.stopRoatating()
        needleView.needleWiseRoatating()
        
        self.roaDesuka = true
        
        self.playMusic()
        backImageView.image = albumImgView.albumImg?.image
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension MainViewController {
    //MARK: - 右抽屉列表(RightFloating)
    @IBAction func getListBtn(sender: AnyObject) {
        
        (UIApplication.sharedApplication().delegate as! AppDelegate).drawerViewController.toggleDrawer(.Right, animated: true) { (finished) -> Void in
            //一个向左推开的动画~(Push To Left)
        }
    }
    
    //MARK: - 手势设置 - 来源于 KGFloatingDrawer (GestureSetting)
    func toggleRightDrawer(sender: UISwipeGestureRecognizer) {
        if(sender.direction == .Left){
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.toggleRightDrawer(sender, animated: true)
        }
    }
    
    //MARK: - 改变图片(ChangeImage)
    func changeImg(img:UIImage) {
        albumImgView.albumImg?.image = img
        backImageView.image = albumImgView.albumImg?.image
    }
    
    //MARK: - 播放按钮控制(MusicControl)
    @IBAction func radioPlayOrStop(sender: AnyObject) {
        if self.roaDesuka {
            albumImgView.stopRoatating()
            self.mPlayer.pause()
            self.roaDesuka = false
            
            pauseBtn.setImage(UIImage(named: "cm2_btn_play"), forState: UIControlState.Normal)
            pauseBtn.setImage(UIImage(named: "cm2_btn_play_prs"), forState: UIControlState.Highlighted)
            
            needleView.needleWiseRoatating()
            
        } else {
            albumImgView.resumeRoatating()
            self.mPlayer.playCurrentItem()
            self.roaDesuka = true
            
            pauseBtn.setImage(UIImage(named: "cm2_btn_pause"), forState: UIControlState.Normal)
            pauseBtn.setImage(UIImage(named: "cm2_btn_pause_prs"), forState: UIControlState.Highlighted)
            
            needleView.needleAntiWiseRoatating()
        }
    }
    
    //MARK: - 重复按钮控制(ReplayControl)
    @IBAction func ReplayCtrl(sender: AnyObject) {
        if self.repDesuka {
            self.repDesuka = false
            
            
            replayBtn.setImage(UIImage(named: "cm2_play_btn_loop_prs"), forState: UIControlState.Normal)
            replayBtn.setImage(UIImage(named: "cm2_play_btn_loop"), forState: UIControlState.Highlighted)
        } else {
            self.repDesuka = true
            
            
            replayBtn.setImage(UIImage(named: "cm2_play_btn_one_prs"), forState: UIControlState.Normal)
            replayBtn.setImage(UIImage(named: "cm2_play_btn_one"), forState: UIControlState.Highlighted)
        }
    }
    
    //MARK: - 特色键 - Oh！键(Special - Oh? Button)
    @IBAction func ohBtn(sender: AnyObject) {
        let channelMenu = UIAlertController(title: "Oh? Menu Loaded~", message: "显示可切换音乐来源完毕！", preferredStyle: UIAlertControllerStyle.ActionSheet)
        let douBtn = UIAlertAction(title: "豆瓣", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
            //MARK: - 豆瓣来源切换设置(DoubanSetting)
            _ = UIAlertView(title: "你知道嘛", message: "现在这个按钮，还有左下角右下角的按钮，都是没用的呢", delegate: self, cancelButtonTitle: "没用你放出来干嘛呢！").show()
            
        }
        let luoBtn = UIAlertAction(title: "落网", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
            //MARK: - 落网来源切换设置(LuonetSetting)
            _ = UIAlertView(title: "你知道嘛", message: "现在这个按钮，还有左下角右下角的按钮，都是没用的呢", delegate: self, cancelButtonTitle: "没用你放出来干嘛呢！").show()
        }
        let huiBtn = UIAlertAction(title: "回声", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
            //MARK: - 回声来源切换设置(EchoSetting)
            _ = UIAlertView(title: "你知道嘛", message: "现在这个按钮，还有左下角右下角的按钮，都是没用的呢", delegate: self, cancelButtonTitle: "没用你放出来干嘛呢！").show()
        }
        let musicInfo = UIAlertAction(title: "我想知道我在听什么！", style: UIAlertActionStyle.Default) { (alertAction) -> Void in
            let alert = UIAlertController(title: "♪(^∇^*)Tell you ~", message: "人家叫做：《\(self.titleLabel.text!)》\n收录在《\(self.albumTitle)》呢！~\n是“\(self.artistLabel.text!)”唱给你听的呢~\n\nsong的比特率是：\(self.songKbsLabel!)kbps!\n\n祝你听得开心♪(^∇^*)\n", preferredStyle: UIAlertControllerStyle.Alert)
            let cennel = UIAlertAction(title: "(⊙o⊙)哦~", style: UIAlertActionStyle.Cancel, handler: nil)
            alert.addAction(cennel)
            self.presentViewController(alert, animated: true, completion: nil)
        }
        let cancel = UIAlertAction(title: "只是想看看这里有什嘛…", style: UIAlertActionStyle.Cancel, handler: nil)
        channelMenu.addAction(douBtn)
        channelMenu.addAction(luoBtn)
        channelMenu.addAction(huiBtn)
        channelMenu.addAction(musicInfo)
        channelMenu.addAction(cancel)
        self.presentViewController(channelMenu, animated: true, completion: nil)
        
        let popover = channelMenu.popoverPresentationController
        if (popover != nil){
            popover?.sourceView = sender as? UIView
            popover?.sourceRect = sender.bounds
            popover?.permittedArrowDirections = UIPopoverArrowDirection.Any
        }
    }
}
