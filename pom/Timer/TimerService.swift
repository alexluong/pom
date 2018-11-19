//
//  TimerService.swift
//  pom
//
//  Created by Alex Luong on 11/18/18.
//  Copyright © 2018 Alex Luong. All rights reserved.
//

import Foundation

enum TimerStatus {
    case running
    case paused
    case stopped
}

struct TimerData {
    var total: Int
    var remaining: Int
    var status: TimerStatus
}

protocol TimerServiceDelegate {
    func onTimerTick(timerData: TimerData)
    func onTimerAction(timerData: TimerData)
}

extension TimerServiceDelegate {
    func onTimerTick(timerData: TimerData) {}
    func onTimerAction(timerData: TimerData) {}
}

class TimerService {
    
    var total = 0
    var remaining = 0
    var timer: Timer!
    var timerStatus = TimerStatus.stopped
    var timerData: TimerData!
    
    var delegate: TimerServiceDelegate?
    
    public func setTime(seconds: Int) {
        total = seconds
    }
    
    public func start() {
        remaining = total
        startTimer()
        callOnAction()
    }
    
    public func stop() {
        timerStatus = TimerStatus.paused
        timer?.invalidate()
        callOnAction()
    }
    
    public func resume() {
        startTimer()
        callOnAction()
    }
    
    private func startTimer() {
        print("start")
        timerStatus = TimerStatus.running
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
    }
    
    @objc private func tick() {
        if remaining == 0 {
            timerStatus = TimerStatus.stopped
            timer.invalidate()
        } else {
            remaining -= 1
        }
        
        timerData = createTimerData()
        delegate?.onTimerTick(timerData: timerData)
    }
    
    private func callOnAction() {
        timerData = createTimerData()
        delegate?.onTimerAction(timerData: timerData)
    }
    
    private func createTimerData() -> TimerData {
        return TimerData(total: total, remaining: remaining, status: timerStatus)
    }
    
}
