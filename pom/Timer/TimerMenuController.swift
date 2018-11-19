//
//  MoreMenuController.swift
//  pom
//
//  Created by Alex Luong on 11/19/18.
//  Copyright © 2018 Alex Luong. All rights reserved.
//

import Cocoa

extension TimerViewController {
    
    func createMenu() {
        moreMenu = NSMenu()

        moreMenu.addItem(NSMenuItem(title: "Do Stuff", action: #selector(self.doStuff(_:)), keyEquivalent: "a"))
        moreMenu.addItem(NSMenuItem(title: "Preferences...", action: #selector(self.preferences(_:)), keyEquivalent: ""))
        moreMenu.addItem(NSMenuItem.separator())
        moreMenu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
    }
    
    @objc func doStuff(_ sender: Any?) {
        print("doStuff")
    }
    
    @objc private func preferences(_ sender: Any?) {
        print("preferences")
    }
    
}
