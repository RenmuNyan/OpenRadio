//
//  LoadAnimationView.swift
//  OpenRadio
//
//  Created by DreamLover on 2016/03/02.
//  Copyright © 2016年 Renmu. All rights reserved.
//

import UIKit
import KVNProgress

class LoadAnimationView: UIView {
    
    func loadingAni() {
        KVNProgress.showWithStatus("正在加载中...")
    }    
    func successAni() {
        KVNProgress.showSuccessWithStatus("频道音乐加载完毕o(>ω< )o")
    }
    func netErrAni() {
        KVNProgress.showErrorWithStatus("请检查网络！╭(°A°`)╮")
    }
    func musicErrAni() {
        KVNProgress.showErrorWithStatus("获取不到歌曲！╭(°A°`)╮")
    }
    func stopAni() {
        KVNProgress.dismiss()
    }
    
}
