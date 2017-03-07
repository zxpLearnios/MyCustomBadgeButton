//
//  Tab_subVC!.swift
//  test_Colsure
//
//  Created by Jingnan Zhang on 16/5/10.
//  Copyright © 2016年 Jingnan Zhang. All rights reserved.
//

import UIKit

class Tab_subVC_: UIViewController,UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  0. 自定义的item的图片的尺寸 必须符合要求 才可显示出来；尺寸不对的，估计TVC得用纯代码写
        let item = UITabBarItem()
        self.title = "第一个"
        item.image = UIImage(named: "item_bg")
        item.image?.withRenderingMode(.alwaysOriginal)
        self.tabBarItem = item // 代码自定义自己的tabbarItem
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "cdfg", style: .plain, target: self, action: nil)
        // 1. 用SB时，item的选中图片貌似只能用代码设置
//        let image = UIImage(named: "Customer_select")
//        let newImage = image?.imageWithRenderingMode(.AlwaysOriginal)
//        self.tabBarItem.selectedImage  = newImage
//    
        
        
//        self.navigationController?.interactivePopGestureRecognizer!.delegate = self
        
    }
//    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
//        if self.navigationController?.viewControllers.count > 1 {
//            return true
//        }else{
//            return false
//        }
//    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.navigationController?.pushViewController(VCpushedByFirstVC(), animated: true)
    }

}
