//
//  MyBadgeButton.swift
//  test_Colsure
//
//  Created by Jingnan Zhang on 16/5/23.
//  Copyright © 2016年 Jingnan Zhang. All rights reserved.

//  完全OK的 封装； 和qq的效果一致
//  0. 长按手势的按钮 ，必须设置提醒内容后，才会出现（默认是隐藏的）
//  1. 初始化， 2.之后外部调用addInsideCircleInSuperView   3.最后加自己到父视图即可，此时内圆已在自己下面了，  4. 设置badgeText  (2, 3的顺序注意即可，其他顺序不要管)

import UIKit

// -----------------  提示文字 按钮 ------  pan手势 ----------------- //
let longPressBadgeBtnH:CGFloat = 14.5 //也是默认时的图片的大小

class MyLongPressBadgeButton: UIButton, CAAnimationDelegate {
    
    
    let scaleMultiple:CGFloat = 1.3 // 缩放的倍数
    let  shapLayer = CAShapeLayer() // 移动是的路径
    var insideCircle = UIButton() // 内圆
    var self_Frame = CGRect() // 记录自己的frame，以便可以返回自己原来的位置
    let groupAniKey = "grounp_Ani"
    
    var image = UIImage()
    
    lazy var images:[UIImage] = {
        var ary = [UIImage]()
        for i in 1...8 {
            let name = String(i)
            
            let  image1 = UIImage.init(named: name)!
            ary.append(image1)
        }
        return ary
    }()
    
    
    
    private var _badgeText = ""
    var badgeText:String {
        get{
            return self._badgeText
        }
        set{
            self._badgeText = newValue
            if badgeText != "" && badgeText != "0" && badgeText.count != 0{
                self.isHidden = false
                self.setTitle(badgeText, for: UIControlState())
                self.setTitle(badgeText, for: .highlighted)
                
                var frame = self.frame
                let  badgeH = self.currentBackgroundImage!.size.height;
                var  badgeW = self.currentBackgroundImage!.size.width;
                if badgeText.count > 1 {
                    let badgeSize = (badgeText as NSString).size(attributes: [NSFontAttributeName: (self.titleLabel?.font)!])
                    badgeW = badgeSize.width + 10
                }
                frame.size.width = badgeW
                frame.size.height = badgeH
                self.frame = frame
                
                let newImage = self.stretchImage(image, withPrecent: 0.5)
                self.setBackgroundImage(newImage, for: UIControlState())
                self.setBackgroundImage(newImage, for: .highlighted)
                // 刷新
                setNeedsLayout()
            }else{
                self.isHidden = true
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
    
    
    // MARK: 初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.doInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self_Frame = frame
    }
    
    
    // 重写属性
    private func doInit(){
        
        self.adjustsImageWhenHighlighted = false
        self.adjustsImageWhenDisabled = false
        
        image = UIImage(named: "gesture_pre_confirm")!
        self.setBackgroundImage(image, for: UIControlState())
        self.setBackgroundImage(image, for: .highlighted)
        self.setBackgroundImage(image, for: .disabled)
        
        self.titleLabel?.textAlignment = .center
        self.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        self.titleLabel?.textColor = UIColor.black
        self.isHidden = true // 默认隐藏
        
        // 点击
        self.addTarget(self, action: #selector(clickAction), for: .touchUpInside)
        
        // 长按手势
        let longPress = UILongPressGestureRecognizer.init(target: self, action: #selector(longGestureAction))
        longPress.minimumPressDuration = 1.0 // 最少得按住1s
        self.addGestureRecognizer(longPress)
        
    }
    
    
    // MARK:  加一个和自己默认大小一样的内圆 btn ，在父视图
    /**
       外部必须调
     */
    func addInsideCircleInSuperView(_ superView: UIView){
        
        insideCircle.frame =  CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: longPressBadgeBtnH, height: longPressBadgeBtnH)
        insideCircle.isEnabled = false
        insideCircle.isHidden = true // 默认也是隐藏的
        insideCircle.adjustsImageWhenDisabled = false
        
        let inside_image = UIImage(named: "gesture_pre_confirm")!
        insideCircle.setBackgroundImage(inside_image, for: UIControlState())
        insideCircle.setBackgroundImage(inside_image, for: .disabled)
        superView.addSubview(insideCircle)
    }
    
    // MARK: 点击事件
    func clickAction(_ button: MyLongPressBadgeButton) {
       
        button.isHidden = true // 隐藏提醒按钮
        button.doDismissAnimate(button.center) // 把自己的center在父view的坐标传过去
    }
    
    // MARK: 长按手势事件
    func longGestureAction(_ long: UILongPressGestureRecognizer) {
        self.handleGeture(long)
    }
    
    // MARK: 缩放、shake动画
    private func handleGeture(_ long: UILongPressGestureRecognizer){
        self.layer.removeAnimation(forKey: groupAniKey)
        
        if long.state == .began { // 开始
            self.doShakeAnimate()
        }else if long.state == .changed{ // 改变
            
            self.layer.removeAnimation(forKey: groupAniKey)
            
            let point = long.location(in: self)
            self.center.x += point.x
            self.center.y += point.y
            
            
            insideCircle.isHidden = false
            self.doChangeAnimate(self,insideCircle: insideCircle)
            
        }else if long.state == .ended { // 结束
            self.doEndAnimate(self, toView: insideCircle)
        }
    }
    
    
    // MARK: Change 时的动画
    private func doChangeAnimate(_ aniView:MyLongPressBadgeButton, insideCircle:UIButton){
        
        if aniView.isRemoveShapleyer {
            insideCircle.isHidden = true
            return
        }
        
        let dis = aniView.calculateDistanceFromPoint(fromPoint: aniView.center, toPoint: insideCircle.center)
        let scale = 1 - (dis/300.0)
        
        insideCircle.transform = CGAffineTransform(scaleX: scale, y: scale) // 缩放内圆
        
        let r1 = insideCircle.frame.height / 2
        if dis >= 150 {
            insideCircle.isHidden = true
            insideCircle.transform = CGAffineTransform(scaleX: scale, y: scale)
            aniView.shapLayer.removeFromSuperlayer()
            aniView.isRemoveShapleyer = true
            return
        }
        
        let r2 = longPressBadgeBtnH/2
        
        let smallCenter = insideCircle.center
        let x1 = smallCenter.x
        let y1 = smallCenter.y
        
        let bigCenter = aniView.center
        let x2 = bigCenter.x
        let y2 = bigCenter.y
        
        let d = aniView.calculateDistanceFromPoint(fromPoint: smallCenter, toPoint: bigCenter)
        let cosθ = (y2 - y1) / d
        let sinθ = (x2 - x1) / d
        
        let pointA = CGPoint(x: x1 - r1 * cosθ , y: y1 + r1 * sinθ);
        let pointB = CGPoint(x: x1 + r1 * cosθ , y: y1 - r1 * sinθ);
        let pointC = CGPoint(x: x2 + r2 * cosθ , y: y2 - r2 * sinθ);
        let pointD = CGPoint(x: x2 - r2 * cosθ , y: y2 + r2 * sinθ);
        let pointO = CGPoint(x: pointA.x + d / 2 * sinθ , y: pointA.y + d / 2 * cosθ);
        let pointP = CGPoint(x: pointB.x + d / 2 * sinθ , y: pointB.y + d / 2 * cosθ);
        
        let path = UIBezierPath.init()
        path.move(to: pointA)
        path.addLine(to: pointB)
        path.addQuadCurve(to: pointC, controlPoint: pointP)
        path.addLine(to: pointD)
        path.addQuadCurve(to: pointA, controlPoint: pointO)
        
        // shapelayer
        aniView.shapLayer.fillColor = UIColor.orange.cgColor
        aniView.shapLayer.path = path.cgPath
        self.superview!.layer.addSublayer(shapLayer)
        
    }
    
    // MARK: Failed、End、Cancle时的动画
    private func doEndAnimate(_ fromView:MyLongPressBadgeButton, toView:UIButton){
        
        let distance = fromView.calculateDistanceFromPoint(fromPoint: fromView.center, toPoint: toView.center)
        
        if distance > 150 && shapLayer.path != nil{
            print("移动距离到临界值了")
            // 执行点击事件的方法
            fromView.clickAction(fromView)
        }else{
            
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 1, options: UIViewAnimationOptions(), animations: {
                fromView.frame.origin.x = toView.frame.origin.x
                fromView.frame.origin.y = toView.frame.origin.y
                }, completion: { (finish) in
                    toView.isHidden = true
                    fromView.isRemoveShapleyer = false
            })
            
        }
        if fromView.shapLayer.path != nil {
            fromView.shapLayer.removeFromSuperlayer()
        }
    }
    
    // MARK:  CAAnimationDelegate
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool){
        if flag  {
            self.layer.removeAllAnimations()
            self.frame = self_Frame
            self.isEnabled = true
            self.isAnimating = false
        }
    }
    
    
    
    // MARK: -----------------  private  ---------------- //
    
    private func doShakeAnimate(){
        self.layer.removeAnimation(forKey: groupAniKey)
        
        let scaleAni = CABasicAnimation.init(keyPath: "transform.scale")
        scaleAni.toValue  = NSValue.init(cgPoint: CGPoint(x: scaleMultiple, y: scaleMultiple))
        
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
        grounpAni.delegate = self // 代理不同，故aniViewAry 要作为全局的了
        
        self.layer.add(grounpAni, forKey: groupAniKey)
    }
    
    // MARK: 消失动画
    private func doDismissAnimate(_ atPoint:CGPoint){
        let aniImageView = UIImageView.init()
        aniImageView.bounds = CGRect(x: 0, y: 0, width: longPressBadgeBtnH * 2,  height: longPressBadgeBtnH * 2)
        aniImageView.center = atPoint
        
        aniImageView.animationImages = images
        aniImageView.animationRepeatCount = 3
        aniImageView.animationDuration = 0.5
        aniImageView.startAnimating()
        self.superview!.addSubview(aniImageView)
        
         self.frame = self_Frame // 恢复至原位置
        isRemoveShapleyer = false // 恢复默认
    }
    
    
    // MARK: 计算两点间距
    private func calculateDistanceFromPoint(fromPoint from :CGPoint, toPoint to:CGPoint) -> CGFloat{
        let number:CGFloat = (from.x - to.x) * (from.x - to.x) + (from.y - to.y)*(from.y - to.y)
        let length = sqrt(number)
        return length
    }
    
    // MARK:  拉伸图片  precent  0---1 拉伸1*1的范围
    private func stretchImage(_ image:UIImage, withPrecent percent :CGFloat) -> UIImage {
        //        let imgSize = CGSizeMake(image.size.width, image.size.height)
        let newImg = image.stretchableImage(withLeftCapWidth: NSInteger(image.size.width * percent), topCapHeight: NSInteger(image.size.height * percent))
        return newImg
    }
}

