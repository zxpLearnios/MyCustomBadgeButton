//
//  MyCustomTVC.swift
//  test_Colsure
//
//  Created by Jingnan Zhang on 16/5/10.
//  Copyright © 2016年 Jingnan Zhang. All rights reserved.
//  自定义TVC, 使用提醒按钮

import UIKit



class MyCustomTVC: UITabBarController {
//    var customTabBar = MyCUstomTabBar()
    
    
/*
    // MARK: xib\代码  都会调之，但此类型只会调一次
    override class func initialize() {
        self.doInit()
    }
    
    // MARK: 做一些事
    class  func doInit() {
        //        self.tabBar.barTintColor = UIColor.redColor()
        
        // 所有的字控制器的tabbarItem的 字体属性
        let tabbarItem = UITabBarItem.appearance() // 不能用UIBarButtonItem
        let itemAttributeNormal = [NSFontAttributeName: UIFont.systemFontOfSize(10), NSForegroundColorAttributeName: UIColor.redColor()]
        let itemAttributeHighlight = [NSFontAttributeName: UIFont.systemFontOfSize(10), NSForegroundColorAttributeName: UIColor.greenColor()]
        
        tabbarItem.setTitleTextAttributes(itemAttributeNormal, forState: .Normal)
        tabbarItem.setTitleTextAttributes(itemAttributeHighlight, forState: .Selected) // 用highlight无效
        
        //   此处设置tabbarItem的图片无效(估计纯代码情况下也是无效)
        //        tabBarItem.image = UIImage(named: "Customer_select")
        //        tabBarItem.selectedImage = UIImage(named: "Customer_unselect")
    }
    */
    var childVCs = [UIViewController]()
    
    // MARK: 单例
    static let shareInstanceObj = MyCustomTVC()
    class func shareInstance() -> MyCustomTVC {
        shareInstanceObj.doInit()
        return shareInstanceObj
    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        self.doInit()
//        
//    }
    func doInit() {
//        self.tabBar.barTintColor = UIColor.red
        
        // 所有的字控制器的tabbarItem的 字体属性
        let tabbarItem = UITabBarItem.appearance() // 不能用UIBarButtonItem
        let itemAttributeNormal = [NSFontAttributeName: UIFont.systemFont(ofSize: 10), NSForegroundColorAttributeName: UIColor.red]
        let itemAttributeHighlight = [NSFontAttributeName: UIFont.systemFont(ofSize: 10), NSForegroundColorAttributeName: UIColor.green]
        
        tabbarItem.setTitleTextAttributes(itemAttributeNormal, for: UIControlState())
        tabbarItem.setTitleTextAttributes(itemAttributeHighlight, for: .selected) // 用highlight无效
        
        //   此处设置tabbarItem的图片无效(估计纯代码情况下也是无效)
        //        tabBarItem.image = UIImage(named: "Customer_select")
        //        tabBarItem.selectedImage = UIImage(named: "Customer_unselect")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.doInit()
        
        let fistVC = Tab_subVC_()
        fistVC.view.backgroundColor = UIColor.gray
        self.addChildViewControllers(fistVC, title: "第一个红色", itemImage: UIImage(named: "Customer_unselect"), itemSelectedImage: UIImage(named: "Customer_select"))
        
        let secondVC = Tab_subVC2()
        self.view.backgroundColor = UIColor.orange
        self.addChildViewControllers(secondVC, title: "第二个红色", itemImage: UIImage(named: "Customer_unselect"), itemSelectedImage: UIImage(named: "Customer_select"))
        
    }

    
   override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        for i in 0..<self.tabBar.subviews.count {
            let item = self.tabBar.subviews[i]
            if item.superview != nil && item.isKind(of: UIControl.self) {
                
                let csBadgeBtn = MyCustomBadgeButton.init(frame: CGRect(x: item.center.x + 15, y: 5, width: MyCustomBadgeButtonH, height: MyCustomBadgeButtonH))
                
                // 1. 先加内圆
                csBadgeBtn.addInsideCircleInSuperView(self.tabBar)
                
                if item.center.x > 200 {
                    csBadgeBtn.badgeText = "1212"
                }else{
                    csBadgeBtn.badgeText = "1"
                }
                
                // 2. 添加到tabbaritem上面
                self.tabBar.addSubview(csBadgeBtn)
            }
            
        }
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
               
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: 添加子控制器
    fileprivate func addChildViewControllers(_ viewController:UIViewController, title:String, itemImage:UIImage?, itemSelectedImage:UIImage?){
       
        let newItemSelectdImg = itemSelectedImage?.withRenderingMode(.alwaysOriginal)
        
        viewController.title = title
//        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = itemImage
        viewController.tabBarItem.selectedImage = newItemSelectdImg
        let nav = MyCustomNav.init(rootViewController: viewController)
        
//        childVCs.append(viewController)
//        self.viewControllers = childVCs
        
//        self.viewControllers?.append(viewController) // 只这样, 无效
        
        self.addChildViewController(nav) // 这样亦可
    
    }
}


