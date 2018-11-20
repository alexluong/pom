//
//  MoreMenuController.swift
//  pom
//
//  Created by Alex Luong on 11/19/18.
//  Copyright © 2018 Alex Luong. All rights reserved.
//

import Cocoa

class TimerMenuController: NSObject {
    
    private var timerMenu: NSMenu!
    
    override init() {
        super.init()

        timerMenu = NSMenu()
        timerMenu.addItem(NSMenuItem(title: "Do Stuff", action: #selector(doStuff(_:)), keyEquivalent: "a"))
        timerMenu.addItem(NSMenuItem(title: "Preferences...", action: #selector(preferences(_:)), keyEquivalent: ""))
        timerMenu.addItem(NSMenuItem.separator())
        timerMenu.addItem(NSMenuItem(title: "Quit", action: #selector(terminate), keyEquivalent: "q"))
        
        for item:NSMenuItem in timerMenu.items {
            item.target = self
        }
    }
    
    public func openMenu(event: NSEvent, sender: NSView) {
        NSMenu.popUpContextMenu(timerMenu, with: event, for: sender)
    }
    
    @objc private func doStuff(_ sender: Any?) {
        print("Do Stuff")
    }
    
    @objc private func preferences(_ sender: Any?) {
        print("Preferences")
    }
    
    @objc private func terminate() {
        NSApplication.shared.terminate(nil)
    }
    
}
