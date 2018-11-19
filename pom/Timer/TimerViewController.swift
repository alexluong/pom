//
//  TimerViewController.swift
//  pom
//
//  Created by Alex Luong on 11/18/18.
//  Copyright © 2018 Alex Luong. All rights reserved.
//

import Cocoa

class TimerViewController: NSViewController, TimerServiceDelegate {
    
    @IBOutlet var minuteLabel: NSTextField!
    @IBOutlet var secondLabel: NSTextField!
    @IBOutlet var colonLabel: NSTextField!
    
    let timer = TimerService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        timer.delegate = self
        
        minuteLabel.stringValue = "25"
        secondLabel.stringValue = "00"
        colonLabel.stringValue = ":"
    }
    
    func onTimerTick(timerData: TimerData) {
        setLabels(seconds: timerData.remaining)
    }
    
    func setLabels(seconds: Int) {
        minuteLabel.stringValue = String(format: "%02d", seconds / 60)
        secondLabel.stringValue = String(format: "%02d", seconds % 60)
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
    
    @IBAction func startTimer(_ sender: NSButton) {
        timer.setTime(seconds: 1500) // 25min
        timer.start()
        setLabels(seconds: 1500)
    }
    
    @IBAction func stopTimer(_ sender: NSButton) {
        print("stop")
        timer.stop()
    }
    
}
