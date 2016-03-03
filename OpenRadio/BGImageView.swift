//
//  BGImageView.swift
//  OpenRadio
//
//  Created by DreamLover on 2016/02/21.
//  Copyright © 2016年 Renmu. All rights reserved.
//

import UIKit

class BGImageView: UIImageView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let blurEff = UIBlurEffect(style: UIBlurEffectStyle.Light)
        let visualView = UIVisualEffectView(effect: blurEff)
        
        visualView.frame = CGRectMake(0, 0, self.frame.size.width * 3, self.frame.size.height * 5)
        visualView.alpha = 1.0
        
        self.addSubview(visualView)
        
    }
}
