//
//  NavigationViewController.swift
//  MBMacKit
//
//  Created by xiaojie li on 2024/8/4.
//

import Cocoa

fileprivate var MBViewControllerAnimatorDelegate_isPush: UInt8 = 0
fileprivate let kMBRecommondAnimationDuration: CFTimeInterval = 0.35

@objc protocol MBViewControllerAnimatorDelegate {
    func animation(from view : NSView , type  animation : NavigationController.NavigationControllerAnimation) -> CABasicAnimation!
    func animation(to view : NSView , type  animation : NavigationController.NavigationControllerAnimation) -> CAAnimation!
    
}
extension MBViewControllerAnimatorDelegate {
    var isPush : Bool {
        get {
            if objc_getAssociatedObject(self, &MBViewControllerAnimatorDelegate_isPush) as? Bool == nil {
                objc_setAssociatedObject(self, &MBViewControllerAnimatorDelegate_isPush, true, .OBJC_ASSOCIATION_ASSIGN)
                return true
            }
            return (objc_getAssociatedObject(self, &MBViewControllerAnimatorDelegate_isPush) as? Bool)!
        }
        set {
            objc_setAssociatedObject(self, &MBViewControllerAnimatorDelegate_isPush, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
}
extension NavigationController {
    @objc enum NavigationControllerAnimation : Int {
        /// 左右动画
        case leftRight
        /// 上下动画
        case upDown
    }
}
extension NSViewController {
    static private var navigationKey : UInt8 = 0
    var navigation : NavigationController {
        set{
            objc_setAssociatedObject(self, &NSViewController.navigationKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return  objc_getAssociatedObject(self, &NSViewController.navigationKey) as! NavigationController
        }
    }
}
@objc class NavigationController: NSViewController {
    // MARK: - 属性
    /// 顶部控制器
    public private(set) var top: NSViewController?
    /// 控制器数组
    public var controllers : [NSViewController] = []
    /// root controller
    public var root : NSViewController?
    /// 是否正在动画中
    public var isAnimation : Bool = false
    /// 动画
    public var animator : MBNavigationAnimation = MBNavigationAnimation()
    /// 动画
    public var contentView : NSView = NSView()
    
    public var animationDelegate : String? {
        didSet {
            if animationDelegate != nil , animationDelegate!.count > 0{
                setAnimationDelegate()
            }
        }
    }
    
    override func loadView() {
        super.loadView()
        view.addSubview(self.contentView)
        updateFrame()
        animator.initialViewController = root
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        animator.container = contentView
        animator.animatorDelegate = self
        top = root
        root?.navigation = self
    }
    /// 更新约束
    func updateFrame(){
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        contentView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        view.layoutSubtreeIfNeeded()
    }
    // MARK: - 方法
    /// 压栈方法
    /// - Parameters:
    ///   - vc: 压栈控制器
    ///   - animated: 是否需要动画 默认需要动画
    ///   - animationType: 动画类型
    public func push(to vc : NSViewController , by  animated : Bool? = true , for animationType : NavigationControllerAnimation? = .leftRight){
        guard animator.inAnimation == false else {
            print("in animation")
            return
        }
        animator.animatorDelegate?.isPush = true
        vc.navigation = self
        top?.viewWillDisappear()
        top = vc
        controllers.append(vc)
        updateNavigationBar()
        vc.viewWillAppear()
        animator.animation(to: vc , isAnimation: animated , animateType: animationType)
    }
    /// 出栈到指定控制器方法
    /// - Parameters:
    ///   - vc: 出栈到控制器 传入的控制器需要在控制器数组中
    ///   - animated: 是否需要动画 默认需要动画
    ///   - animationType: 动画类型
    public func pop(to vc : NSViewController , by  animated : Bool? = true , for animationType : NavigationControllerAnimation?){
    }
    /// 出栈方法
    /// - Parameters:
    ///   - index: 出战到指定index 控制器
    ///   - animated: 是否需要动画 默认需要动画
    ///   - animationType: 动画类型
    public func pop(to index : Int , by  animated : Bool? = true , for animationType : NavigationControllerAnimation?){
    }
    /// 交换控制器
    /// - Parameters:
    ///   - tVC: 需要交换的控制器
    ///   - fVC: 交换到指定控制器 默认到最后一个
    ///   - animated: 是否需要动画 默认需要动画
    ///   - animationType: 动画类型
    public func exchange(to tVC : NSViewController , from fVC : NSViewController? = nil , by  animated : Bool? = true , for animationType : NavigationControllerAnimation?){
    }
    /// 出栈到 root 控制器
    /// - Parameters:
    ///   - animated: 是否需要动画 默认需要动画
    ///   - animationType: 动画类型
    public func toRoot(by  animated : Bool? = true , for animationType : NavigationControllerAnimation?){
    }
    
    /// 更新导航栏
    public func updateNavigationBar (){
        
    }
    
}
extension NavigationController {
    private func setAnimationDelegate () {
        if let aniDelegate = (NSClassFromString(animationDelegate!) ?? nil)?.initialize() as?  MBViewControllerAnimatorDelegate{
            self.animator.animatorDelegate = aniDelegate
        }
    }
}
// MARK: - DYViewControllerAnimatorDelegate 方法
extension NavigationController : MBViewControllerAnimatorDelegate {
    func animation(from view: NSView, type animation: NavigationControllerAnimation) -> CABasicAnimation! {
        if animation  == .leftRight {
            let animation = MBAnimation.mbFadeOut()
            animation.duration = kMBRecommondAnimationDuration
            animation.fillMode = .both
//            animation.beginTime = CACurrentMediaTime()
            animation.isRemovedOnCompletion = false
            return animation
        }else if animation == .upDown {
            
        }
        return CABasicAnimation()
    }
    
    func animation(to view: NSView, type animation: NavigationControllerAnimation) -> CAAnimation! {
        if animation  == .leftRight {
            let animation = MBAnimation.mbFadeIn(value: 0.0)
            let move = MBAnimation.mbMoveXFrom(value: Float(isPush ? (view.layer?.position.x)! + 30.0 : (view.layer?.position.x)! - 30.0))
            let group  = CAAnimationGroup()
            group.animations = [animation , move]
            group.fillMode = .backwards
            group.beginTime = CACurrentMediaTime() + kMBRecommondAnimationDuration
            group.isRemovedOnCompletion = false
            return group
         }else if animation == .upDown {
            
        }
        return CABasicAnimation()
    }
}

extension NavigationController {
    
    
    class MBNavigationAnimation : NSObject, CAAnimationDelegate {
        // MARK: - 宏定义
        let kMBViewControllerAnimationFromKey = "com.Danyang.animator.animation.from"
        let kMBViewControllerAnimationToKey = "com.Danyang.animator.animation.to"
        // MARK: - 属性
        /// to view
        private var mba_ToView : NSView?
        /// to viewcontroller
        private var mba_ToViewController : NSViewController?
        /// from view
        private var mba_FromView : NSView?
        /// from viewcontroller
        private var mba_FromViewController : NSViewController?
        /// 动画代理
        public var animatorDelegate : MBViewControllerAnimatorDelegate?
        ///  是否动画中
        public var inAnimation : Bool? = false
        /// content view
        public var container : NSView?{
            didSet{
                __initial()
            }
        }
        /// 初始化控制器
        public var initialViewController : NSViewController?{
            didSet {
                __initial()
            }
        }
        // MARK: - 方法
        
        /// 动画方法
        /// - Parameters:
        ///   - vc: 控制器
        ///   - animation: 是否动画
        ///   - type: 动画类型
        public func animation(to vc : NSViewController , isAnimation animation: Bool? = true , animateType type: NavigationController.NavigationControllerAnimation? = .leftRight){
            if mba_FromView == nil , mba_ToView != nil {//第一次的时候需要切换view 角色
                print("first switch view")
                mba_FromView = mba_ToView
                mba_FromViewController = mba_ToViewController
                mba_ToView = nil
                mba_ToViewController = nil
            }
            guard mba_ToView == nil else {
                print("to View not nil")
                return
            }
            guard animatorDelegate != nil else {
                print("animatorDelegate is nil")
                return
            }
            inAnimation = true
            addViewController(vc)
            if animation! == true { // 需要动画
                mba_ToView?.layer?.removeAllAnimations()
                mba_FromView?.layer?.removeAllAnimations()
                mba_ToView?.wantsLayer = true
                mba_FromView?.wantsLayer = true
                
                let fromAnimation = animatorDelegate!.animation(from: mba_FromView!, type: type!)
                fromAnimation!.delegate = self
                let toAnimation = animatorDelegate!.animation(to: mba_ToView!, type: type!)
                toAnimation!.delegate = self
                mba_FromView?.layer?.add(fromAnimation!, forKey: kMBViewControllerAnimationFromKey)
                mba_ToView?.layer?.add(toAnimation!, forKey: kMBViewControllerAnimationToKey)
             }else{//不需要动画
                mba_FromView?.removeFromSuperview()
                mba_FromView = mba_ToView
                mba_ToViewController = mba_FromViewController
                inAnimation = false
                mba_ToView = nil
                mba_ToViewController = nil
            }
            
        }
        private func __initial(){
            guard let initViewController = initialViewController  else {
                print("init controller view is exist!")
                return
            }
            guard let _ = container  else {
                print("content view is exist!")
                return
            }
            self.addViewController(initViewController)
            
        }
        private func addViewController(_ vc : NSViewController){
            self.mba_ToView = vc.view
            self.mba_ToViewController = vc
            guard let containerView = container  else {
                print("addContentView content view is exist!")
                return
            }
            guard let a_ToView = self.mba_ToView  else {
                print("toView content view is not exist!")
                return
            }
            guard containerView.superview != nil  else {
                print("toView content view is not exist!")
                return
            }
            a_ToView.frame = NSRect(x: 0, y: 0, width: containerView.frame.width, height: containerView.frame.height)
            containerView.addSubview(a_ToView)
            a_ToView.autoresizingMask = [.width , .height , .maxXMargin , .maxYMargin , .minXMargin , .minYMargin]
        }
        
    }
    
}
extension NavigationController.MBNavigationAnimation  {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if anim.isEqual(mba_FromView?.layer?.animation(forKey: kMBViewControllerAnimationFromKey))  {
            mba_FromView?.removeFromSuperview()
            mba_FromView?.layer?.removeAllAnimations()
            mba_FromView = nil
            mba_FromViewController = nil
        }
        if mba_FromView == nil  {
            mba_FromView = mba_ToView
            mba_FromViewController = mba_ToViewController
            inAnimation = false
            mba_ToView = nil
            mba_ToViewController = nil
        }
    }
}
