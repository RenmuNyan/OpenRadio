//
//  ViewController.swift
//  OpenRadio
//
//  Created by DreamLover on 2016/01/26.
//  Copyright © 2016年 Renmu. All rights reserved.
//

import UIKit

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
        
        HttpReq().getSong(0) { (music) -> Void in
            if music.songUrl != nil {
                self.titleLabel.text  = NSString(string: music.songTitle) as String
                self.artistLabel.text = NSString(string: music.artist) as String
                
                self.changeImg(UIImage(data: NSData(contentsOfURL: NSURL(string: music.albumImg)!)!)!)
                
                self.albumImgView.resumeRoatating()
                self.needleView.needleAntiWiseRoatating()
                
                self.pauseBtn.setImage(UIImage(named: "cm2_btn_pause"), forState: UIControlState.Normal)
                self.pauseBtn.setImage(UIImage(named: "cm2_btn_pause_prs"), forState: UIControlState.Highlighted)
                
                MusicPlayModel().getMusic()
            }
        }
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
            //To ...
        }
    }
    
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
            self.roaDesuka = false
            
            pauseBtn.setImage(UIImage(named: "cm2_btn_play"), forState: UIControlState.Normal)
            pauseBtn.setImage(UIImage(named: "cm2_btn_play_prs"), forState: UIControlState.Highlighted)
            
            needleView.needleWiseRoatating()
            
        } else {
            albumImgView.resumeRoatating()
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
    
    @IBAction func ohBtn(sender: AnyObject) {
        let channelMenu = UIAlertController(title: "切换音乐来源", message: "显示可切换音乐来源完毕！", preferredStyle: UIAlertControllerStyle.ActionSheet)
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
        let cancel = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
        channelMenu.addAction(douBtn)
        channelMenu.addAction(luoBtn)
        channelMenu.addAction(huiBtn)
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

