//
//  NeedleView.swift
//  OpenRadio
//
//  Created by DreamLover on 2016/02/22.
//  Copyright © 2016年 Renmu. All rights reserved.
//

import UIKit

class NeedleView: UIImageView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let view = UIImageView(frame: CGRectMake(0, 0, 104, 174))
        
        self.image = UIImage(named: "cm2_play_needle_play-ip6")
        self.layer.anchorPoint = CGPointMake(0.25, 0.16)
        self.transform = CGAffineTransformMakeRotation(CGFloat(-0.08))
        
        self.addSubview(view)
    }
    
    //MARK: - 唱针旋转动画(NeedleRoatating)
    func needleWiseRoatating() {
        UIView.animateWithDuration(0.4, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
            
                self.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI / 6))  //逆时针，让唱针走开！
            
            }) { (finished) -> Void in
        }
    }
    
    func needleAntiWiseRoatating() {
        UIView.animateWithDuration(0.4, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
            
            self.transform = CGAffineTransformMakeRotation(CGFloat(-0.08))  //顺时针，转回来！
            
            }) { (finished) -> Void in
        }
    }

}
