//
//  AppDelegate.swift
//  pom
//
//  Created by Alex Luong on 11/18/18.
//  Copyright © 2018 Alex Luong. All rights reserved.
//

// TODO: Move timer to another thread

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, CountdownServiceDelegate {

    @IBOutlet weak var statusMenu: NSMenu!
    @IBOutlet weak var startMenuItem: NSMenuItem!
    @IBOutlet weak var stopMenuItem: NSMenuItem!
    @IBOutlet weak var resumeMenuItem: NSMenuItem!
    @IBOutlet weak var quitMenuItem: NSMenuItem!
    
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    let countdown = CountdownService()
    
    @IBAction func startClicked(_ sender: NSMenuItem) {
        countdown.setTime(seconds: 200)
        countdown.start()
    }
    
    @IBAction func stopClicked(_ sender: NSMenuItem) {
        print("stop")
        countdown.stop()
    }
    
    @IBAction func resumeClicked(_ sender: Any) {
        print("resume")
        countdown.resume()
    }
    
    @IBAction func quitClicked(_ sender: NSMenuItem) {
        NSApplication.shared.terminate(self)
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        countdown.delegate = self
        
        statusItem.title = "Pom"
        statusItem.menu = statusMenu
        setMenuBarItemEnability(status: TimerStatus.stopped)
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Tear down
    }
    
    func onTimerTick(total: Int, remaining: Int, status: TimerStatus) {
        statusItem.title = String(remaining)
    }
    
    func onTimerAction(total: Int, remaining: Int, status: TimerStatus) {
        setMenuBarItemEnability(status: status)
    }
    
    func setMenuBarItemEnability(status: TimerStatus) {
        switch status {
        case .running:
            startMenuItem.isEnabled = false
            stopMenuItem.isEnabled = true
            resumeMenuItem.isEnabled = false
        case .stopped:
            startMenuItem.isEnabled = true
            stopMenuItem.isEnabled = false
            resumeMenuItem.isEnabled = false
        case .paused:
            startMenuItem.isEnabled = true
            stopMenuItem.isEnabled = false
            resumeMenuItem.isEnabled = true
        }
        quitMenuItem.isEnabled = true
    }

}
