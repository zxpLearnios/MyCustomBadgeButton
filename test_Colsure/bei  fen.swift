
//
//  bei  fen.swift
//  test_Colsure
//
//  Created by Jingnan Zhang on 16/5/13.
//  Copyright © 2016年 Jingnan Zhang. All rights reserved.
//

import UIKit

class bei__fen: NSObject {

}
/*
 
 //
 //  MyCustomTVC.swift
 //  test_Colsure
 //
 //  Created by Jingnan Zhang on 16/5/10.
 //  Copyright © 2016年 Jingnan Zhang. All rights reserved.
 //  自定义TVC
 
 import UIKit
 
 
 
 class MyCustomTVC: UITabBarController {
 //    var customTabBar = MyCUstomTabBar()
 
 
 /*
 // MARK: xib\代码  都会调之
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
 
 // MARK: 单例
 static let shareInstanceObj = MyCustomTVC()
 class func shareInstance() -> MyCustomTVC {
 shareInstanceObj.doInit()
 return shareInstanceObj
 }
 
 override func awakeFromNib() {
 super.awakeFromNib()
 self.doInit()
 
 }
 func doInit() {
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
 override func viewDidLoad() {
 super.viewDidLoad()
 //        customTabBar = MyCUstomTabBar.init(frame: self.tabBar.bounds)
 //        addTabBar()
 
 
 }
 
 override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
 }
 
 override func viewWillAppear(animated: Bool) {
 super.viewWillAppear(animated)
 //        for subView in self.tabBar.subviews {
 //            if subView.superview != nil {
 //                if subView.isKindOfClass(UIControl){
 //                    subView.removeFromSuperview()
 //                }
 //
 //            }
 //        }
 for i in 0..<self.tabBar.subviews.count {
 let item = self.tabBar.subviews[i]
 if item.superview != nil && item.isKindOfClass(UIControl) {
 let csBadgeBtn = MyCustomBadgeButton.init(frame: CGRectMake(item.center.x + 15, 5, MyCustomBadgeButtonH, MyCustomBadgeButtonH))
 
 
 if item.center.x > 200 {
 csBadgeBtn.badgeText = "12"
 }else{
 csBadgeBtn.badgeText = "11"
 }
 
 badgeButtons.append(csBadgeBtn)
 }
 
 }
 }
 
 override func viewDidAppear(animated: Bool) {
 super.viewDidAppear(animated)
 
 
 // 1. 在tabbar上加长按手势, 先加内圆
 badgeButtons.first?.addLongGestureAndInsideCircleInSuperView(self.tabBar)
 
 // 2. 再加外圆, 确保内圆，外圆都在item上面
 for btn in badgeButtons {
 self.tabBar.addSubview(btn)
 }
 
 }
 
 
 
 // MARK: 添加自定义的 tabbar
 func addTabBar()  {
 // 设置tabbar, 这里不移除tabbar，只因为其他地方可以和默认的一样用self.tab****
 //        self.tabBar.addSubview(customTabBar)
 }
 // MARK: 添加子控制器
 func addChildViewControllers(itemTitle itemTitle:String, itemImage:UIImage, itemSelectImage:UIImage){
 let childVC = UIViewController()
 let nav = MyCustomNav.init(rootViewController: childVC)
 childVC.tabBarItem.title = itemTitle
 childVC.tabBarItem.image = itemImage
 childVC.tabBarItem.selectedImage = itemSelectImage
 //        customTabBar.addTabBarButtonWithItem(childVC.tabBarItem)
 self.viewControllers = [nav]
 }
 
 override func didReceiveMemoryWarning() {
 super.didReceiveMemoryWarning()
 }
 
 
 }
 
 //class MyCUstomTabBar: UITabBar {
 //
 //
 //
 //    override init(frame: CGRect) {
 //        super.init(frame: frame)
 ////        self.backgroundColor = UIColor.redColor() // 这样设置是无效的
 //        self.barTintColor = UIColor.redColor() // 一个这样设置背景色
 //    }
 //
 //    required init?(coder aDecoder: NSCoder) {
 //        super.init(coder: aDecoder)
 //    }
 //    // MARK: 添加item按钮
 //    func addTabBarButtonWithItem(item: UITabBarItem){
 //        let customTabBarButton = MyCustomTabBarButton()
 //        customTabBarButton.item = item
 //
 //    }
 //
 //    // MARK: 代理方法
 //    func tabBar( didTabBarColsure: ((tabBar:MyCUstomTabBar, from:Int, to:Int) -> Void)? ){
 //        if didTabBarColsure != nil {
 //            didTabBarColsure!(tabBar: self, from: 0, to: 1)
 //        }
 //    }
 //
 //}
 //
 //
 //// tabbar上面的按钮
 //
 //class MyCustomTabBarButton: UIButton {
 //    private var  _item:UITabBarItem?
 //    var item:UITabBarItem?{
 //        get{
 //            return self._item
 //        }
 //        set{
 //            self._item = newValue
 //        }
 //    }
 //
 //    // 重写属性
 //    override var adjustsImageWhenHighlighted: Bool{
 //        get{
 //            return self.adjustsImageWhenHighlighted
 //        }
 //        set{
 //            self.adjustsImageWhenHighlighted = newValue
 //        }
 //    }
 //    // MARK: 重写 image title 的rect
 ////    override func imageRectForContentRect(contentRect: CGRect) -> CGRect {
 ////        return CGRectMake(item?.image.origin.x, <#T##y: CGFloat##CGFloat#>, <#T##width: CGFloat##CGFloat#>, <#T##height: CGFloat##CGFloat#>)
 ////    }
 ////    override func titleRectForContentRect(contentRect: CGRect) -> CGRect {
 ////
 ////    }
 //    // MARK: 初始化
 //    override init(frame: CGRect) {
 //        super.init(frame: frame)
 //        self.doInit()
 //    }
 //    required init?(coder aDecoder: NSCoder) {
 //        super.init(coder: aDecoder)
 //    }
 //
 //    func doInit(){
 //        self.imageView?.contentMode = .Center // 确保安圆大小显示
 //        self.titleLabel?.textAlignment = .Center
 //
 //    }
 //
 //}
 
 // --------------------------  提示文字 按钮 -------------------------------- //
 var badgeButtons = [MyCustomBadgeButton]() // 全局
 let MyCustomBadgeButtonH:CGFloat = 14.5 //也是默认时的图片的大小
 var aniViewAry = [MyCustomBadgeButton]() // 获取到的被点击的提醒按钮
 var aniViewFrameAry = [CGRect]() //  获取到的被点击的提醒按钮的点击时的frame
 var insideCircleAry = [UIButton]() // 内圆，
 var super_View  = UIView()
 
 class MyCustomBadgeButton: UIButton, UIDynamicAnimatorDelegate {
 let scaleMultiple:CGFloat = 2 // 缩放的倍数
 
 let  shapLayer = CAShapeLayer()
 
 
 lazy var images:[UIImage] = {
 var ary = [UIImage]()
 for i in 1...8 {
 let name = String(i)
 let  image1 = UIImage.init(named: name)!
 ary.append(image1)
 }
 return ary
 }()
 
 
 var image = UIImage()
 var previousPoint = CGPoint()
 var lastPoint = CGPoint()
 
 var isAnimating = false // 是否正在进行动画
 
 private var _badgeText = ""
 var badgeText:String {
 get{
 return self._badgeText
 }
 set{
 self._badgeText = newValue
 if badgeText != "" && badgeText != "0" {
 self.hidden = false
 self.setTitle(badgeText, forState: .Normal)
 self.setTitle(badgeText, forState: .Highlighted)
 
 var frame = self.frame
 let  badgeH = self.currentBackgroundImage!.size.height;
 var  badgeW = self.currentBackgroundImage!.size.width;
 if badgeText.characters.count > 1 {
 let badgeSize = (badgeText as NSString).sizeWithAttributes([NSFontAttributeName: (self.titleLabel?.font)!])
 badgeW = badgeSize.width + 10
 }
 frame.size.width = badgeW
 frame.size.height = badgeH
 self.frame = frame
 
 let newImage = self.stretchImage(image, withPrecent: 0.5)
 self.setBackgroundImage(newImage, forState: .Normal)
 self.setBackgroundImage(newImage, forState: .Highlighted)
 
 }else{
 self.hidden = true
 }
 }
 }
 
 private var _animate = false
 var animate:Bool {  // 是否执行动画
 get{
 return self._animate
 }
 set{
 self._animate = newValue
 if animate == true {
 }
 }
 
 }
 
 // MARK: 单例
 static let shareInstanceObj = MyCustomBadgeButton()
 class func shareInstance() -> MyCustomBadgeButton {
 return shareInstanceObj
 }
 
 
 // MARK: 初始化
 override init(frame: CGRect) {
 super.init(frame: frame)
 self.doInit()
 }
 required init?(coder aDecoder: NSCoder) {
 super.init(coder: aDecoder)
 }
 
 // 重写属性
 private func doInit(){
 self.adjustsImageWhenHighlighted = false
 self.adjustsImageWhenDisabled = false
 
 image = UIImage(named: "gesture_pre_confirm")!
 self.setBackgroundImage(image, forState: .Normal)
 self.setBackgroundImage(image, forState: .Highlighted)
 self.setBackgroundImage(image, forState: .Disabled)
 
 self.titleLabel?.textAlignment = .Center
 self.titleLabel?.font = UIFont.systemFontOfSize(10)
 self.titleLabel?.textColor = UIColor.blackColor()
 self.hidden = true // 默认隐藏
 
 // 点击
 self.addTarget(self, action: #selector(clickAction), forControlEvents: .TouchUpInside)
 
 NSUserDefaults.standardUserDefaults().setInteger(-1, forKey: "currentIndex")
 NSUserDefaults.standardUserDefaults().setObject(self, forKey: "currentView")
 NSUserDefaults.standardUserDefaults().synchronize()
 }
 
 
 // MARK: 点击事件-- ----只在点击、或在原地长按的情况下才调
 func clickAction(button: MyCustomBadgeButton) {
 
 var center = button.center
 if CGRectContainsPoint(button.frame, lastPoint){
 center = CGPointMake(lastPoint.x, lastPoint.y)
 if aniViewAry.count != 0 {
 let index = aniViewAry.indexOf(button)!
 aniViewAry.removeAtIndex(index)
 aniViewFrameAry.removeAtIndex(index)
 }
 
 button.hidden = true
 }
 self.doDismissAnimate(center)
 }
 
 // MARK: 消失动画
 private func doDismissAnimate(atPoint:CGPoint){
 
 let aniImageView = UIImageView.init()
 aniImageView.bounds = CGRectMake(0, 0, MyCustomBadgeButtonH * 2,  MyCustomBadgeButtonH * 2)
 aniImageView.center = atPoint
 
 aniImageView.animationImages = images
 aniImageView.animationRepeatCount = 3
 aniImageView.animationDuration = 0.5
 aniImageView.startAnimating()
 
 super_View.addSubview(aniImageView)
 }
 
 // MARK: 长按手势
 func addLongGestureAndInsideCircleInSuperView(superView: UIView){
 
 super_View = superView
 
 // 长按手势  加到父view上
 let longPress = UILongPressGestureRecognizer.init(target: self, action: #selector(longPressAction))
 longPress.allowableMovement = UIScreen.mainScreen().bounds.height // 默认的 长按手势最多超出 所加的控件的距离
 //        longPress.minimumPressDuration = 1
 super_View.addGestureRecognizer(longPress)
 
 
 // 加一个和自己默认大小一样的内圆 btn
 for badgeButton in badgeButtons {
 let  insideCircle = UIButton.init(frame: CGRectMake(badgeButton.frame.origin.x, badgeButton.frame.origin.y, MyCustomBadgeButtonH, MyCustomBadgeButtonH))
 insideCircle.enabled = false
 insideCircle.hidden = true // 默认也是隐藏的
 insideCircle.adjustsImageWhenDisabled = false
 
 let inside_image = UIImage(named: "gesture_pre_confirm")!
 insideCircle.setBackgroundImage(inside_image, forState: .Normal)
 insideCircle.setBackgroundImage(inside_image, forState: .Disabled)
 super_View.addSubview(insideCircle)
 
 insideCircleAry.append(insideCircle)
 }
 }
 
 
 // MARK: 长按手势事件
 func longPressAction(longPress:UILongPressGestureRecognizer) {
 
 self.doScaleAndShakeAnimate(aniViewAry, longPress: longPress)
 }
 
 // MARK: --------------------------------  private  ----------------------
 // MARK: 计算两点间距
 private func calculateDistanceFromPoint(fromPoint from :CGPoint, toPoint to:CGPoint) -> CGFloat{
 let number:CGFloat = (from.x - to.x) * (from.x - to.x) + (from.y - to.y)*(from.y - to.y)
 let length = sqrt(number)
 return length
 }
 
 // MARK:  拉伸图片  precent  0---1 拉伸1*1的范围
 private func stretchImage(image:UIImage, withPrecent percent :CGFloat) -> UIImage {
 //        let imgSize = CGSizeMake(image.size.width, image.size.height)
 let newImg = image.stretchableImageWithLeftCapWidth(NSInteger(image.size.width * percent), topCapHeight: NSInteger(image.size.height * percent))
 return newImg
 }
 // MARK: 缩放、shake动画
 private func doScaleAndShakeAnimate(aniViews:[MyCustomBadgeButton], longPress:UILongPressGestureRecognizer){
 
 let state = longPress.state
 if previousPoint == CGPointZero {
 previousPoint = longPress.locationInView(self.superview!)
 lastPoint = longPress.locationInView(self.superview!)
 }else{
 lastPoint = longPress.locationInView(self.superview!)
 }
 
 var currentIndex = -1
 
 var currentV = MyCustomBadgeButton()
 switch state {
 
 case .Possible:
 break
 case .Began:
 
 
 for i  in  0..<badgeButtons.count{
 let subView = badgeButtons[i]
 
 if  CGRectContainsPoint(subView.frame, lastPoint) { // 点击到了提醒按钮 ,点击到了subView
 
 if aniViewAry.count == 0 { // 首次
 aniViewAry.append(subView) // 加入数组
 aniViewFrameAry.append(subView.frame)
 
 NSUserDefaults.standardUserDefaults().setInteger(0, forKey: "currentIndex")
 NSUserDefaults.standardUserDefaults().setObject(subView, forKey: "currentView")
 NSUserDefaults.standardUserDefaults().synchronize()
 }else{ // 非首次
 
 for aniView in aniViewAry {
 
 if aniView != subView && subView.enabled == true { // 重要！！
 
 aniViewAry.append(subView) // 加入数组
 aniViewFrameAry.append(subView.frame)
 
 let ind = aniViewAry.indexOf(aniView)!
 NSUserDefaults.standardUserDefaults().setInteger(ind , forKey: "currentIndex")
 NSUserDefaults.standardUserDefaults().setObject(subView, forKey: "currentView")
 NSUserDefaults.standardUserDefaults().synchronize()
 }
 }
 }
 
 self.doBeganAnimate(aniViewAry)
 }
 
 }
 
 
 case .Changed:
 currentV = NSUserDefaults.standardUserDefaults().objectForKey("currentView") as! MyCustomBadgeButton
 currentV.layer.removeAnimationForKey("grounp_Ani")
 
 let distance = self.calculateDistanceFromPoint(fromPoint: previousPoint, toPoint: lastPoint)
 
 if distance > 5 {
 currentV.center = lastPoint
 
 currentIndex = NSUserDefaults.standardUserDefaults().integerForKey("currentIndex")
 // 显示内圆
 if currentIndex != -1 {
 
 let index = badgeButtons.indexOf(currentV)!
 
 let insideCicle = insideCircleAry[index]
 insideCicle.hidden = false
 
 self.doChangeAnimate(insideCicle.center, currentPoint: lastPoint)
 }
 
 
 }else{ // 距离太小
 
 }
 
 print("改变了")
 
 default: // 取消
 
 shapLayer.removeFromSuperlayer()
 currentIndex = NSUserDefaults.standardUserDefaults().integerForKey("currentIndex")
 
 currentV = NSUserDefaults.standardUserDefaults().objectForKey("currentView") as! MyCustomBadgeButton
 
 // 隐藏内圆
 if currentIndex != -1 {
 let index = badgeButtons.indexOf(currentV)!
 
 let insideCicle = insideCircleAry[index]
 insideCicle.hidden = true
 self.doEndAnimate(currentV, toView: insideCicle, fromPoint: lastPoint, toPoint: insideCicle.center)
 
 }
 print("可能是取消了")
 
 }
 
 
 }
 // MARK:  Began 时的 动画
 private func doBeganAnimate(aniViews:[MyCustomBadgeButton]){
 for aniView in aniViews {
 
 if !aniView.isAnimating  && aniView.enabled == true{
 
 let scaleAni = CABasicAnimation.init(keyPath: "transform.scale")
 scaleAni.toValue  = NSValue.init(CGPoint: CGPointMake(scaleMultiple, scaleMultiple))
 
 let shakeAni = CAKeyframeAnimation.init(keyPath: "transform.translation.x")
 let s = 10
 //   shakeAni.mass = 24 // 质量越大，摩擦越大
 //   shakeAni.damping = 20
 shakeAni.values = [-s, 0, s, 0, -s, 0, s, 0]
 shakeAni.duration = 0.3
 shakeAni.repeatCount = 3
 
 let grounpAni = CAAnimationGroup.init()
 grounpAni.animations = [scaleAni, shakeAni]
 grounpAni.duration = 3
 grounpAni.delegate = aniView // 代理不同，故aniViewAry 要作为全局的了
 
 
 aniView.enabled = false
 aniView.isAnimating = true
 aniView.layer.addAnimation(grounpAni, forKey: "grounp_Ani")
 
 }
 
 }
 
 }
 
 // MARK: Change 时的动画
 private func doChangeAnimate(smallCenter:CGPoint, currentPoint:CGPoint){
 
 let x1 = smallCenter.x
 let y1 = smallCenter.y
 
 let x2 = currentPoint.x
 let y2 = currentPoint.y
 
 let d = calculateDistanceFromPoint(fromPoint: smallCenter, toPoint: currentPoint)
 let cosθ = (y2 - y1) / d
 let sinθ = (x2 - x1) / d
 
 
 //        var r1 = (-1/9)*(MyCustomBadgeButtonH/2) - (100/9) // 内圆半径递减函数
 
 var  r1 = MyCustomBadgeButtonH / 3
 if r1 <= 1 {
 r1 = 1
 }
 let r2 = MyCustomBadgeButtonH/2
 
 
 let pointA = CGPointMake(x1 - r1 * cosθ , y1 + r1 * sinθ);
 let pointB = CGPointMake(x1 + r1 * cosθ , y1 - r1 * sinθ);
 let pointC = CGPointMake(x2 + r2 * cosθ , y2 - r2 * sinθ);
 let pointD = CGPointMake(x2 - r2 * cosθ , y2 + r2 * sinθ);
 let pointO = CGPointMake(pointA.x + d / 2 * sinθ , pointA.y + d / 2 * cosθ);
 let pointP = CGPointMake(pointB.x + d / 2 * sinθ , pointB.y + d / 2 * cosθ);
 
 let path = UIBezierPath.init()
 path.moveToPoint(pointA)
 path.addLineToPoint(pointB)
 path.addQuadCurveToPoint(pointC, controlPoint: pointP)
 path.addLineToPoint(pointD)
 path.addQuadCurveToPoint(pointA, controlPoint: pointO)
 
 // shapelayer
 shapLayer.fillColor = UIColor.orangeColor().CGColor
 shapLayer.path = path.CGPath
 super_View.layer.addSublayer(shapLayer)
 
 }
 
 // MARK: Failed、End、Cancle时的动画
 private func doEndAnimate(fromView:MyCustomBadgeButton, toView:UIButton, fromPoint:CGPoint, toPoint:CGPoint){
 
 let distance = self.calculateDistanceFromPoint(fromPoint: fromPoint, toPoint: toPoint)
 if distance > 130 {
 
 // 执行 消失动画
 fromView.hidden = true
 toView.hidden = true
 let index = aniViewAry.indexOf(fromView)!
 aniViewAry.removeAtIndex(index)
 aniViewFrameAry.removeAtIndex(index)
 
 self.doDismissAnimate(fromPoint)
 }else{
 
 UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 1, options: .CurveEaseInOut, animations: {
 fromView.center = toView.center
 }, completion: { (finish) in
 toView.hidden = true
 fromView.isAnimating = false // 必须设置
 })
 }
 
 }
 
 // MARK: UIDynamicAnimatorDelegate
 
 override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
 
 if flag && anim.isKindOfClass(CAAnimationGroup){ // 动画通知的时刻 不可能一样，即每刻只会通知一个动画
 
 let aniV = anim.delegate as! MyCustomBadgeButton
 if aniViewAry.count != 0 {
 let index = aniViewAry.indexOf(aniV)! // 索引
 let frame = aniViewFrameAry[index]
 
 aniV.layer.removeAnimationForKey("grounp_Ani")
 aniV.layer.frame = frame
 aniV.isAnimating = false
 aniV.enabled = true
 aniViewAry.removeAtIndex(index) // 数组移除数据
 aniViewFrameAry.removeAtIndex(index) // 数组移除数据
 }
 }
 }
 }
 

 */