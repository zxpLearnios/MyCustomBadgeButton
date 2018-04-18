//
//  CALayer_extension.swift
//  test_Colsure
//
//  Created by Jingnan Zhang on 16/5/17.
//  Copyright © 2016年 Jingnan Zhang. All rights reserved.
//

import UIKit

class CALayer_extension: NSObject {

}

extension CALayer{

    // MARK: 暂停layer的动画
     func pauseLayerAnimate() {
        let pausedTime = self.convertTime(CACurrentMediaTime(), from: nil)
        self.speed = 0.0
        self.timeOffset = pausedTime
        
    }
    
    // MARK: 重新开始layer的动画
    func reStartLayerAnimate() {
        let pausedTime = self.timeOffset
        self.speed = 1.0
        self.beginTime = 0.0
        let timeSincePauce = self.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        self.beginTime = timeSincePauce
    }
}
