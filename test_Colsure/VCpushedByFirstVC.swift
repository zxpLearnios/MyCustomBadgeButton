//
//  VCpushedByFirstVC.swift
//  test_Colsure
//
//  Created by Jingnan Zhang on 16/5/11.
//  Copyright © 2016年 Jingnan Zhang. All rights reserved.
//  测试了长按手势的提醒按钮

import UIKit

class VCpushedByFirstVC: UIViewController {

    var testBadgeBtn:MyLongPressBadgeButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "第一个VCpush出来的"
     
        self.view.backgroundColor = UIColor.white
        
        // 测试1
        for i in 0...1 {
            let longPressBtn = MyLongPressBadgeButton.init(frame: CGRect(x: 100 + CGFloat(i)*100, y: 100, width: 50, height: 50))
            
            longPressBtn.addInsideCircleInSuperView(self.view)
            self.view.addSubview(longPressBtn)
             longPressBtn.badgeText = "ferf"
            testBadgeBtn = longPressBtn
            
        }
        
        // 测试2
        let time = DispatchTime.now() + Double(Int64(10 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: time) {
            self.testBadgeBtn.badgeText = "再次出来了，证明完全OK"
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    deinit{
//        print("------  deinit ----")
//    }

}
