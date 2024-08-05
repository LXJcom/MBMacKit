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

        // Do any additional setup after loading the view.
        navigation = NavigationController()
        view.addSubview(navigation.view)
        navigation.view.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        navigation.view.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        navigation.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        navigation.view.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
    }



}

