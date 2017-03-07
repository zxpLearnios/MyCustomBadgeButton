//
//  ViewController.swift
//  test_Colsure
//
//  Created by Jingnan Zhang on 16/5/9.
//  Copyright © 2016年 Jingnan Zhang. All rights reserved.
//  闭包等 新知识

import UIKit

// 闭包的三种写法
typealias colsure = (_ str:String) -> Void 
var colsure1:((_ str:String) -> String) = {str in return str }
let colsure2:((_ str:String) -> String) = {str in return str + "你好"}

class ViewController: UIViewController, UITabBarDelegate {

    @IBOutlet weak var navBarItem: UINavigationItem!
    
    @IBOutlet weak var tabBar: UITabBar!
    
    @IBOutlet weak var firstTabBarItem: UITabBarItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 0. 
//        let item_tabBar = UITabBarItem.init(title: "服装", image: UIImage(named: "1"), tag: 0)
//        
//        item_tabBar.image?.imageWithRenderingMode(.AlwaysOriginal)
        //        tabBar.items = [item_tabBar]
        
        
        navBarItem.title = "\(self.classForCoder)"

        
        // 1. 数组
        let ary = [1, 2.0, 3]
        doRide(ary)
        doSort(ary)
//        UIDevice.currentDevice().name
        // 2.字典根据key排序
//        let dic = ["1":11, "3":32, "2":22.0]
////        let newDic = dic.keys.sort() // 自动将key由小到大排序
//        let newDic = dic.values.sort() // 自动将value由小到大排序
        
        // 3.字符串
//        let str = "梵蒂冈高胆固醇"
//        str[str.startIndex.successor()] //第一个下标的下一个值
//        str[str.endIndex.predecessor()] //最后一个下标的上一个值
        
        // 4.元祖
//        let tuple1 = ("1", 2, 3.0, ["s", 1])
//        let tuple2 = (a:"a", b:"b", c:1)
//        
//        let ft = tuple1.0
//        let ft1 = tuple2.a // tuple2.0
//        
        /*
        // 5. 集合 -- set
        //定义一个元素类型为字符的空set
        let emptySet = Set<Character>()
        let vomel:Set<Character> = ["a","e","i","o","u"];
        var evenSet:Set = [2,4,6,8,10] //类型推断
        evenSet.count   //该set的个数
        evenSet.removeFirst()   //移除set的第一个元素
        evenSet.insert(25)      //插入一个元素25
        evenSet.contains(4)    //判断是否包含
        //因为set是无序集合,想要保证一定顺序可以使用sort
        for number in evenSet.sort(){
            print(number)
        }
        
        //setA 和 setB 的交集
        var setA : Set = [1,2,3,4,5]
        var setB : Set = [5,6,7,8]
        let setiAB : Set = setA.intersect(setB)
        //setA 和 setB 的对称差
        let  seteAB : Set = setA.exclusiveOr(setB)
        //setA 和 setB 的并集
        let unionAB : Set = setA.union(setB)
        //setA对于setB的补集
        let subAB : Set = setA.subtract(setB)
        
        //判断集合是否相等
        if setA == setB{
            print("相等")
        }else{
            print("不相等")
        }
        
        setB.isSupersetOf(setA) //判断B是否是A的超集
        setB.isSubsetOf(setA)//判断B是否是A的子集

        // 6.判断
        let me = "gsdgfsd"
        
        switch me{
        case "a","e","i","o","u":
            print("这个是元音")
        default:
            print("这个不是元音")
        }
        
        let number = 56
        switch number{
        case 1...10:
            print("这个数在1-10之间")
        case 11...99:
            print("这个数在11-99之间")
        default:
            print("这个数大于100")
        }
        
        let point = (1,1)
        switch point{
        case (0,0):
            print("在原点")
        case (_,0):
            print("在x轴上")
        case (0,_):
            print("在y轴上")
        case (-2...2,-2...2):
            print("在该范围内")
        default:
            print("位置跑偏")
        }
        */
        
        // 7.  闭包
//        let standCl = { (a:Int) -> Bool in
//            return a > 10; true; false
//        }
//        print(standCl(1))
        
        let simpleCl = { (str:String) in
            print(str)
        }
        simpleCl("这是简单的闭包形式\n")
        
        
//        let cl = { // 不传入参数
//            print("--执行了")
//        }()
        
//        let cl1 = {str in  // 传入参数
//            print("\(str)")
//        }("-----执行了")
        
//        let x = 42
//        let cl2 = {
//             x in
//            print("传入了----\(x)")
//        }(x)
//        let cl2 = {
////            [x] // [x] 没用
//            print("传入了----\(x)")
//        }()
//        let cl2 = {
////            x // 没用的x
//            print("传入了----\(x)")
//        }()
        
//        let cl3 = {
//            print("嘿嘿--")
//        }
//        cl3()
        
        
    }
    
   
    // MARK:  点击屏幕
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let myvc = MyVC()
        
        self.present(myvc, animated: true) {
            // 0.测试闭包回调
//            myvc.setTitleForSelf("文字来自ViewController", cl: { (a) in
//                self.navBarItem.title = a
//            })
//            myvc.setBgColorWithColsure(UIColor(red: 36/255.0, green: 200/255.0, blue: 147/255.0, alpha: 1.0), colsure: { (color) in
//                self.view.backgroundColor = color // 此color是闭包里的参数，来自于MyVC
//            })
            myvc.setBgColorForVC({ (color) in  // 可以去掉最外层的()
                self.view.backgroundColor = color
            })
            // 1. 自身恢复原态
//            self.navBarItem.title = "\(self.classForCoder)"
//            self.tabBar.selectedItem = self.firstTabBarItem  // 选中第一个
        }
    }
    // MARK: UITabBarDelegate -代理方法
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        navBarItem.title = "第\(item.tag)个item"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK:  数组的每个元素统乘以*
    func doRide(_ ary: Array<Double>) -> [Double]{
        let newAry = ary.map{$0 * 2}
        
        return newAry
    }
    // MARK:  排序
    func doSort (_ ary: [Double]) -> [Double] {
        
        let newAry = ary.filter({$0 > 1})
        return newAry
    }
    
    
}

