//
//  ViewController.swift
//  MBMacKit
//
//  Created by xiaojie li on 2024/8/4.
//

import Cocoa


class ViewController: NSViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.wantsLayer = true
        view.layer?.backgroundColor = randomColor().cgColor
        self.view.mbAddArea()
    }
    override func mouseUp(with event: NSEvent) {
        super.mouseUp(with: event)
        guard let navi = navigation  else { return  }
        guard navi.controllers.count < 4 else {
            navi.pop()
            return
        }
        let vc = ViewController()
        navi.push(to: ViewController())
        
    }
    func randomColor() -> NSColor {
        let red = CGFloat(arc4random_uniform(256)) / 255.0
        let green = CGFloat(arc4random_uniform(256)) / 255.0
        let blue = CGFloat(arc4random_uniform(256)) / 255.0
        return NSColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

