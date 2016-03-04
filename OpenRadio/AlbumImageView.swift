//
//  AlbumImageView.swift
//  OpenRadio
//
//  Created by DreamLover on 2016/02/21.
//  Copyright © 2016年 Renmu. All rights reserved.
//

import UIKit

class AlbumImageView: UIImageView {
    
    var albumImg:UIImageView?

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.albumImg = UIImageView(frame: CGRectMake(self.frame.size.width/2 - 75, self.frame.size.height/2 - 18, 158, 158))
        self.albumImg?.clipsToBounds = true
        self.albumImg?.layer.cornerRadius = 79
        
        self.albumImg?.image = UIImage(named: "TitleImage")
        
        self.addSubview(self.albumImg!)
    }
    
    //MARK: - 专辑图片转动方法(AlbumImage_Roatating)
    func startRoatating() {
        let roaAni = CABasicAnimation(keyPath: "transform.rotation")
        
        roaAni.fromValue = 0.0
        roaAni.toValue = M_PI * 2
        roaAni.duration = 50
        roaAni.repeatCount = MAXFLOAT
        
        self.layer.addAnimation(roaAni, forKey: nil)
    }
    
    //MARK: - 专辑图片停止方法(AlbumImage_StopRoatating)
    func stopRoatating() {
        let stopRoaAni = self.layer.convertTime(CACurrentMediaTime(), fromLayer: nil)
        self.layer.speed = 0.0
        self.layer.timeOffset = stopRoaAni
    }
    
    //MARK: - 专辑图片恢复方法(AlbumImage_ResumeRoatating)
    func resumeRoatating() {
        let resRoaAni = self.layer.timeOffset
        self.layer.speed = 1.0
        self.layer.timeOffset = 0.0
        self.layer.beginTime = 0.0
        
        let timeStop = self.layer.convertTime(CACurrentMediaTime(), fromLayer: nil) - resRoaAni
        layer.beginTime = timeStop
    }
    
}
