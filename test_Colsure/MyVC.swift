//
//  MyVC.swift
//  test_Colsure
//
//  Created by Jingnan Zhang on 16/5/9.
//  Copyright © 2016年 Jingnan Zhang. All rights reserved.
//  闭包

import UIKit

class MyVC: UIViewController {

  
    
    @IBOutlet weak var navBarItem: UINavigationItem!
    var clInMyVC:colsure? // 闭包
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBarItem.title = "\(self.classForCoder)"
    }

    
    // MARK: 带闭包的函数1, 闭包回调
    func setTitleForSelf(_ str:String, cl:@escaping colsure) {
       navBarItem.title = str
        clInMyVC = cl
        if clInMyVC != nil {
            clInMyVC!("文字来自MyVC")
        }
    }
    
    // MARK: 闭包回调2
    func setBgColorWithColsure(_ color:UIColor, colsure: @escaping (_ color:UIColor) -> Void)  {
        self.view.backgroundColor = color // 此color是本函数的第一个参数，来自于VC
        let cl = colsure
        cl(UIColor.red) // 作为回调，即用于设置VC的背景色
        
    }
    // MARK: 设置VC 的颜色，
    func setBgColorForVC(_ colorColsure: ((_ color:UIColor) -> Void)? ) {
        if colorColsure != nil {
            colorColsure!(UIColor.orange)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // 点击屏幕
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true, completion: nil)
    }
}
