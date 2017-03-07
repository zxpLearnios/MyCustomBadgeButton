//
//  MyCustomTVC.swift
//  test_Colsure
//
//  Created by Jingnan Zhang on 16/5/10.
//  Copyright © 2016年 Jingnan Zhang. All rights reserved.
//  自定义TVC

/*
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
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        for i in 0..<self.tabBar.subviews.count {
            let item = self.tabBar.subviews[i]
            if item.superview != nil && item.isKindOfClass(UIControl) {
                let csBadgeBtn = MyCustomBadgeButton.init(frame: CGRectMake(item.center.x + 15, 5, MyCustomBadgeButtonH, MyCustomBadgeButtonH))
                
                
                if item.center.x > 200 {
                    csBadgeBtn.badgeText = "1212"
                }else{
                    csBadgeBtn.badgeText = "1111"
                }
                
                badgeButtons.append(csBadgeBtn)
            }
            
        }
        
        for btn in badgeButtons {
            badgeButtonFrames.append(btn.frame)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
        // 1. 在tabbar上加长按手势, 先加内圆
        badgeButtons.first?.addInsideCircleInSuperView(self.tabBar)
        
        // 2. 再加外圆, 确保内圆，外圆都在item上面
        for btn in badgeButtons {
            self.tabBar.addSubview(btn)
        }
        
        //
        //        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(2 * Double(NSEC_PER_SEC)))
        //        dispatch_after(time, dispatch_get_main_queue()) {
        //            let dyna = UIDynamicAnimator.init(referenceView: self.tabBar)
        //            let  atBh = UIAttachmentBehavior.init(item: badgeButtons[1], attachedToAnchor: badgeButtons[1].center)
        //            atBh.length = 0 // item的center距吸附点的长度, 必须设置
        //            atBh.damping  = 50 // 阻尼， 剧烈程度, 太大时（>500），移向吸附点的速度变慢
        //            //        atBh.frequency = 50 // 频率, 会一直颤抖(但必须length=0)
        //            //        atBh.frictionTorque = 500 // 摩擦扭矩
        //
        //            dyna.addBehavior(atBh)
        //        }
        
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


// --------------------------  提示文字 按钮 ------  长按手势 ----------------- //
var badgeButtons = [MyCustomBadgeButton]() // 全局
var badgeButtonFrames = [CGRect]()
let MyCustomBadgeButtonH:CGFloat = 14.5 //也是默认时的图片的大小

var insideCircleAry = [UIButton]() // 内圆，
var super_View  = UIView()

class MyCustomBadgeButton: UIButton, UIDynamicAnimatorDelegate {
    let scaleMultiple:CGFloat = 1.3 // 缩放的倍数
    
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
    
    private var _isAnimating = false
    var isAnimating:Bool {  // 是否执行动画
        get{
            return self._isAnimating
        }
        set{
            self._isAnimating = newValue
        }
        
    }
    
    private var _isRemoveShapleyer = false
    var isRemoveShapleyer:Bool {  // 是否执行动画
        get{
            return self._isRemoveShapleyer
        }
        set{
            self._isRemoveShapleyer = newValue
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
        NSUserDefaults.standardUserDefaults().synchronize()
        
        // 长按手势
        let longPress = UILongPressGestureRecognizer.init(target: self, action: #selector(longPressAction))
        //        longPress.allowableMovement = UIScreen.mainScreen().bounds.height // 默认的 长按手势最多超出 所加的控件的距离
        longPress.minimumPressDuration = 1
        self.addGestureRecognizer(longPress)
    }
    
    // MARK: 点击事件
    func clickAction(button: MyCustomBadgeButton) {
        if shapLayer.path == nil {
            return
        }
        
        button.hidden = true // 隐藏提醒按钮
        button.doDismissAnimate(button.center) // 把自己的center在父view的坐标传过去
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
    
    // MARK: 加内圆在父view上
    func addInsideCircleInSuperView(superView: UIView){
        
        super_View = superView
        
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
        
        self.doScaleAndShakeAnimate(longPress)
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
    private func doScaleAndShakeAnimate(longPress:UILongPressGestureRecognizer){
        
        let view = longPress.view as! MyCustomBadgeButton
        let index = badgeButtons.indexOf(view)!
        let badgeBtn = badgeButtons[index] // 取到的才是父view中的提醒按钮, badgeButtons[index] = self
        
        let badgeBtnCenter = badgeBtn.center
        let longPressCenter = longPress.locationInView(badgeBtn)
        
        // 状态
        let state = longPress.state
        
        // 点击的点
        if previousPoint == CGPointZero {
            
            previousPoint = CGPointMake(longPressCenter.x + badgeBtnCenter.x - MyCustomBadgeButtonH, longPressCenter.y + badgeBtnCenter.y - MyCustomBadgeButtonH)
            
            lastPoint = previousPoint
        }else{
            lastPoint = CGPointMake(longPressCenter.x + badgeBtnCenter.x, longPressCenter.y + badgeBtnCenter.y)
        }
        
        var currentIndex = -1
        
        
        switch state {
            
        case .Possible:
            break
        case .Began: // 直接做Began动画
            self.doBeganAnimate(badgeBtn)
            
            let index = badgeButtons.indexOf(badgeBtn)!
            NSUserDefaults.standardUserDefaults().setInteger(index, forKey: "currentIndex")
            NSUserDefaults.standardUserDefaults().synchronize()
            
        case .Changed:
            //            let dis = badgeBtn.calculateDistanceFromPoint(fromPoint: badgeBtn.center, toPoint: lastPoint)
            
            //            if  dis >= 10 && {
            //
            //            }
            
            let distance = badgeBtn.calculateDistanceFromPoint(fromPoint: previousPoint, toPoint: lastPoint)
            
            if distance > 5 {
                // 移除动画
                badgeBtn.layer.removeAnimationForKey("grounp_Ani")
                badgeBtn.isAnimating = false
                badgeBtn.enabled = true
                
                badgeBtn.center = lastPoint
                let currentIndex = NSUserDefaults.standardUserDefaults().integerForKey("currentIndex")
                
                // 显示内圆
                if currentIndex != -1 {
                    
                    let  insideCicle = insideCircleAry[currentIndex]
                    insideCicle.hidden = false
                    
                    badgeBtn.doChangeAnimate(badgeBtn, insideCircle: insideCicle, smallCenter: insideCicle.center, currentPoint: badgeBtn.center) // 父坐标系的值
                }
                
                
            }else{ // 距离太小
                
            }
            
            print("改变了")
            
        default: // 取消
            
            currentIndex = NSUserDefaults.standardUserDefaults().integerForKey("currentIndex")
            
            // 隐藏内圆
            if currentIndex != -1 {
                
                let insideCicle = insideCircleAry[currentIndex]
                insideCicle.hidden = true
                badgeBtn.doEndAnimate(badgeButtons[currentIndex], toView: insideCicle, fromPoint: lastPoint, toPoint: insideCicle.center)
            }
            print("可能是取消\\停止\\失败")
            
        }
        
        
    }
    // MARK:  Began 时的 动画
    private func doBeganAnimate(aniView: MyCustomBadgeButton){
        if !aniView.isAnimating  { // 不会再view上重复加动画le
            
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
            grounpAni.duration = 1
            grounpAni.delegate = aniView // 代理不同，故aniViewAry 要作为全局的了
            
            
            aniView.enabled = false
            aniView.isAnimating = true
            aniView.layer.addAnimation(grounpAni, forKey: "grounp_Ani")
        }
        
        
    }
    
    // MARK: Change 时的动画
    private func doChangeAnimate(aniView:MyCustomBadgeButton, insideCircle:UIButton, smallCenter:CGPoint, currentPoint:CGPoint){
        
        if aniView.isRemoveShapleyer {
            insideCircle.hidden = true
            return
        }
        
        let dis = aniView.calculateDistanceFromPoint(fromPoint: smallCenter, toPoint: currentPoint)
        let scale = 1 - (dis/300.0)
        
        insideCircle.transform = CGAffineTransformMakeScale(scale, scale) // 缩放内圆
        
        let r1 = insideCircle.frame.height / 2
        
        //        var  r1 = MyCustomBadgeButtonH / 3
        //        if r1 <= 1 {
        //            r1 = 1
        //        }
        
        if dis >= 150 {
            insideCircle.hidden = true
            insideCircle.transform = CGAffineTransformMakeScale(scale, scale)
            aniView.shapLayer.removeFromSuperlayer()
            aniView.isRemoveShapleyer = true
            return
        }
        
        let r2 = MyCustomBadgeButtonH/2
        
        let x1 = smallCenter.x
        let y1 = smallCenter.y
        
        let x2 = currentPoint.x
        let y2 = currentPoint.y
        
        let d = aniView.calculateDistanceFromPoint(fromPoint: smallCenter, toPoint: currentPoint)
        let cosθ = (y2 - y1) / d
        let sinθ = (x2 - x1) / d
        
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
        aniView.shapLayer.fillColor = UIColor.orangeColor().CGColor
        aniView.shapLayer.path = path.CGPath
        super_View.layer.addSublayer(shapLayer)
        
    }
    
    // MARK: Failed、End、Cancle时的动画
    private func doEndAnimate(fromView:MyCustomBadgeButton, toView:UIButton, fromPoint:CGPoint, toPoint:CGPoint){
        
        let distance = fromView.calculateDistanceFromPoint(fromPoint: fromPoint, toPoint: toPoint)
        
        if distance > 150 && shapLayer.path != nil{
            print("移动距离到临界值了")
            // 执行点击事件的方法
            fromView.clickAction(fromView)
        }else{
            
            UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 1, options: .CurveEaseInOut, animations: {
                fromView.frame.origin.x = toView.frame.origin.x
                fromView.frame.origin.y = toView.frame.origin.y
                }, completion: { (finish) in
                    toView.hidden = true
                    fromView.isRemoveShapleyer = false
            })
            
        }
        if fromView.shapLayer.path != nil {
            fromView.shapLayer.removeFromSuperlayer()
        }
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        
        
        if flag && anim .isKindOfClass(CAAnimationGroup)  { // 动画通知的时刻 不可能一样，即每刻只会通知一个动画
            let aniV = anim.delegate as! MyCustomBadgeButton
            aniV.layer.removeAllAnimations()
            
            let index = badgeButtons.indexOf(aniV)!
            aniV.frame = badgeButtonFrames[index]
            
            aniV.enabled = true
            aniV.isAnimating = false
        }
    }
}

*/