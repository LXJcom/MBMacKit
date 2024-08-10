//
//  NavigationViewController.swift
//  MBMacKit
//
//  Created by xiaojie li on 2024/8/4.
//

import Cocoa

extension NavigationController {
    enum NavigationControllerAnimation {
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
class NavigationController: NSViewController {
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
    
    
    override func loadView() {
        super.loadView()
        self.view.addSubview(self.contentView)
        updateFrame()
        contentView.wantsLayer = true
        contentView.layer?.backgroundColor = NSColor.white.cgColor

    }
   
    /// 更新约束
    func updateFrame(){
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        contentView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
     // MARK: - 方法
    /// 压栈方法
    /// - Parameters:
    ///   - vc: 压栈控制器
    ///   - animated: 是否需要动画 默认需要动画
    ///   - animationType: 动画类型
    public func push(to vc : NSViewController , by  animated : Bool? = true , for animationType : NavigationControllerAnimation?){
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
    
}
extension NavigationController {
     class MBNavigationAnimation : NSObject {
        
    }
}
