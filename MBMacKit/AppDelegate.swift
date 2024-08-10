//
//  AppDelegate.swift
//  MBMacKit
//
//  Created by xiaojie li on 2024/8/4.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    var myWindow : NSWindow = NSWindow()
    


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        let VC = NavigationController()
        VC.root = ViewController()
//        VC.root?.view.wantsLayer = true
//        VC.root?.view.layer?.backgroundColor = NSColor.red./*c*/gColor
        myWindow.contentViewController = VC
        myWindow.setFrame(NSRect(x:100, y: 100, width: 700, height: 400), display: true)
        myWindow.makeKeyAndOrderFront(nil)
        //        myWindow.contentView?.addSubview(ViewController().view)
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }



}

