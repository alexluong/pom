//
//  AppDelegate.swift
//  pom
//
//  Created by Alex Luong on 11/18/18.
//  Copyright © 2018 Alex Luong. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, CountdownServiceDelegate {

    @IBOutlet weak var statusMenu: NSMenu!
    
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    let countdown = CountdownService()
    
    @IBAction func quitClicked(_ sender: NSMenuItem) {
        NSApplication.shared.terminate(self)
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        countdown.delegate = self

        countdown.setTime(seconds: 200)
        countdown.start()
        
        statusItem.title = "Hello"
        statusItem.menu = statusMenu
    }
    
    func onTick(total: Int, remaining: Int) {
        statusItem.title = String(remaining)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Tear down
    }

}
