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
        myWindow.setFrame(NSRect(x:100, y: 100, width: 100, height: 100), display: true)
//        myWindow.orderOut(nil)
        myWindow.makeKeyAndOrderFront(nil)
        myWindow.contentView?.addSubview(ViewController().view)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }



}

