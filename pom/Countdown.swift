//
//  Timer.swift
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

protocol CountdownServiceDelegate {
    func onTimerTick(total: Int, remaining: Int, status: TimerStatus)
    func onTimerAction(total: Int, remaining: Int, status: TimerStatus)
}

class CountdownService {
    
    var total = 0
    var remaining = 0
    var timer: Timer!
    var timerStatus = TimerStatus.stopped
    
    var delegate: CountdownServiceDelegate?
    
    public func setTime(seconds: Int) {
        total = seconds
    }
    
    public func start() {
        remaining = total
        startTimer()
        delegate?.onTimerAction(total: total, remaining: remaining, status: timerStatus)
    }
    
    public func stop() {
        timerStatus = TimerStatus.paused
        timer?.invalidate()
        delegate?.onTimerAction(total: total, remaining: remaining, status: timerStatus)
    }
    
    public func resume() {
        startTimer()
        delegate?.onTimerAction(total: total, remaining: remaining, status: timerStatus)
    }
    
    private func startTimer() {
        timerStatus = TimerStatus.running
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
    }
    
    @objc private func tick() {
        delegate?.onTimerTick(total: total, remaining: remaining, status: timerStatus)
        
        if remaining == 0 {
            timerStatus = TimerStatus.stopped
            timer.invalidate()
        } else {
            remaining -= 1
        }
    }
}
