//
//  MBAnimation.swift
//  MBMacKit
//
//  Created by xiaojie li on 2024/8/10.
//

import Foundation
import QuartzCore
enum MBKCategory : String {
    case rotation = "transform.rotation"
    case position = "position"
    case positionX = "position.x"
    case positionY = "position.y"
    case bounds = "bounds"
    case scale = "transform.scale"
    case opacity = "opacity"
    case translate = "transform"
}
@objc class MBAnimation : NSObject{
    // MARK: - 方法
    class func mAFrom(category :  MBKCategory) -> CABasicAnimation {
        let ani : CABasicAnimation = CABasicAnimation.init(keyPath: category.rawValue)
        ani.isRemovedOnCompletion = false
        ani.fillMode = .forwards
        ani.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        return ani
    }
    class func _ma(ani : CABasicAnimation , from : Any? , by : Any? , to: Any?) {
        ani.fromValue = from
        ani.byValue = by
        ani.toValue = to
    }
}

extension MBAnimation {
    class func mbFadeOut() -> CABasicAnimation{
        let ani = mAFrom(category: .opacity)
        _ma(ani: ani , from: nil, by: nil, to: 0)
        return ani
    }
  class func mbFadeIn() -> CABasicAnimation{
        let ani = mAFrom(category: .opacity)
        _ma(ani: ani , from: nil, by: nil, to: 1)
        return ani
    }
    class func mbFadeIn(value : Float) -> CABasicAnimation{
        let ani = mAFrom(category: .opacity)
        _ma(ani: ani , from: value, by: nil, to: 1)
        return ani
    }
    class func mbMoveXFrom(value : Float) -> CABasicAnimation{
        let ani = mAFrom(category: .positionX)
        _ma(ani: ani , from: value, by: nil, to: nil)
        return ani
    }
   class func mbMoveYFrom(value : Float) -> CABasicAnimation{
        let ani = mAFrom(category: .positionY)
        _ma(ani: ani , from: value, by: nil, to: nil)
        return ani
    }
    
}
