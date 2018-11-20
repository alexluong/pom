//
//  TimerViewController.swift
//  pom
//
//  Created by Alex Luong on 11/18/18.
//  Copyright © 2018 Alex Luong. All rights reserved.
//

import Cocoa

enum LeftButtonTitle: String {
    case start = "Start"
    case stop = "Stop"
    case ok = "OK"
}

protocol TimerViewControllerDelegate {
    func onMenuOpen(event: NSEvent, sender: NSView)
}

class TimerViewController: NSViewController, TimerServiceDelegate {
    
    @IBOutlet weak var minuteLabel: NSTextField!
    @IBOutlet weak var secondLabel: NSTextField!
    @IBOutlet weak var colonLabel: NSTextField!
    
    @IBOutlet weak var leftButton: NSButton!
    @IBOutlet weak var rightButton: NSButton!
    @IBOutlet weak var moreButton: NSButton!
    
    private let timer = TimerService()
    private let timerMenuController = TimerMenuController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        timer.delegate = self

        timer.prepare(seconds: 1500)
        
        rightButton.title = "Reset"
    }
    
    // Timer delegate functions
    func onTimerAction(timerData: TimerData) {
        if timerData.status == .ready {
            setLabels(seconds: timerData.remaining)
        }

        setButtons(status: timerData.status)
    }
    
    func onTimerTick(timerData: TimerData) {
        setLabels(seconds: timerData.remaining)
    }
    
    // Helper functions
    func setLabels(seconds: Int) {
        minuteLabel.stringValue = String(format: "%02d", seconds / 60)
        secondLabel.stringValue = String(format: "%02d", seconds % 60)
    }
    
    func setButtons(status: TimerStatus) {
        switch status {
        case .ready:
            leftButton.title = LeftButtonTitle.start.rawValue
        case .running:
            leftButton.title = LeftButtonTitle.stop.rawValue
        case .paused:
            leftButton.title = LeftButtonTitle.start.rawValue
        case .finished:
            leftButton.title = LeftButtonTitle.ok.rawValue
        }
    }
    
}

extension TimerViewController {
    
    // MARK: Storyboard instantiation
    static func freshController() -> TimerViewController {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        
        let identifier = NSStoryboard.SceneIdentifier("TimerViewController")
        
        guard let viewController = storyboard.instantiateController(withIdentifier: identifier) as? TimerViewController else {
            fatalError("Why cant i find TimerViewController? - Check Main.storyboard")
        }
        
        return viewController
    }
    
}

extension TimerViewController {
    
    // Actions
    @IBAction func leftButtonClicked(_ sender: NSButton) {
        let timerStatus = timer.timerData.status
        
        switch timerStatus {
        case .ready:
            timer.start()
        case .running:
            timer.stop()
        case .paused:
            timer.resume()
        case .finished:
            print("finished")
        }
    }
    
    @IBAction func rightButtonClicked(_ sender: NSButton) {
        timer.prepare(seconds: 1500)
    }
    
    @IBAction func moreButtonClicked(_ sender: NSButton) {
        if let event = NSApplication.shared.currentEvent {
            timerMenuController.openMenu(event: event, sender: sender)
        }
    }
    
}
