//
//  MyCustomNav.swift
//  test_Colsure
//
//  Created by Jingnan Zhang on 16/5/11.
//  Copyright © 2016年 Jingnan Zhang. All rights reserved.
//  自定义的NAV, 在类方法里不能使用self.，故此中不用initialize;
//  纯代码、xib使用都可以；可能因为swift自身的问题导致了问题（已经分别测试了oc、swift了）


import UIKit


class MyCustomNav: UINavigationController {

    // 首次使用时 调用
    override class func initialize(){
        
    }
    
    // MARK: 初始化
    func doInit() {
        
//        self.navigationBar.barTintColor = UIColor.redColor()
        // 所有push出的控制器的title的属性设置
        let textAttibute = [NSFontAttributeName: UIFont.systemFont(ofSize: 10), NSForegroundColorAttributeName: UIColor.green]
        self.navigationBar.titleTextAttributes = textAttibute
        
        
        // 所有的push出的控制器左右item的 属性设置, 但item最后不要拖入，因为长按会变暗
        var  navBaritem = UIBarButtonItem()
        if #available(iOS 9.0, *) {
            navBaritem = UIBarButtonItem.appearance(whenContainedInInstancesOf: [MyCustomNav.self])
        } else {
            navBaritem = UIBarButtonItem.appearance()
        }
        let itemAttribute = [NSFontAttributeName: UIFont.systemFont(ofSize: 10), NSForegroundColorAttributeName: UIColor.orange]
        navBaritem.setTitleTextAttributes(itemAttribute, for: UIControlState())
        navBaritem.setTitleTextAttributes(itemAttribute, for: .highlighted) // 不能用selected
        
//        navBaritem.setBackgroundImage(UIImage(named: "2"), forState: .Normal, barMetrics: .Default)
//        navBaritem.setBackgroundImage(UIImage(named: "2"), forState: .Highlighted, barMetrics: .Default)
        
        //  与tabbar有关的， 第一批控制器的标题
        for subVC in self.viewControllers {
            if subVC.tabBarItem != nil {
                subVC.title = subVC.tabBarItem.title
                
            }
        }
        

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.doInit()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: 重写此法以拦截所有push的控制器
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.childViewControllers.count > 0 { // 非第一批控制器时 的情况

//               // 左边的按钮
//                let leftBtn = UIButton.init(frame: CGRectMake(0, 0, 25, 25))
//                leftBtn.setImage(UIImage(named: "navigationbar_back"), forState: .Normal)
//                leftBtn.setImage(UIImage(named: "navigationbar_back"), forState: .Highlighted)
//                leftBtn.addTarget(self, action: #selector(back), forControlEvents: .TouchUpInside)
//                viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftBtn)
//
//                // 右边的按钮

                 viewController.hidesBottomBarWhenPushed = true
            }
            
            super.pushViewController(viewController, animated: animated)
        }
    
    
    // MARK: 返回
    func back() {
        self.popToRootViewController(animated: true)
    }
    
    // MARK: 右边按钮的方法
    func rightItemAction() {
        
    }
}
