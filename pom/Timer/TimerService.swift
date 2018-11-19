//
//  TimerService.swift
//  pom
//
//  Created by Alex Luong on 11/18/18.
//  Copyright © 2018 Alex Luong. All rights reserved.
//

import Foundation

enum TimerStatus {
    case ready
    case running
    case paused
    case finished
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
    
    private var total = 0
    private var remaining = 0
    private var timer: Timer!
    private var timerStatus = TimerStatus.ready
    
    public var timerData = TimerData(total: 0, remaining: 0, status: TimerStatus.ready)
    
    public var delegate: TimerServiceDelegate?
    
    public func prepare(seconds: Int) {
        if timerStatus == .running {
            stop()
        }
        timer = nil
        total = seconds
        remaining = seconds
        timerStatus = TimerStatus.ready
        callOnAction()
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
        timerStatus = TimerStatus.running
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
    }
    
    @objc private func tick() {
        if remaining == 0 {
            timerStatus = TimerStatus.finished
            timer.invalidate()
        } else {
            remaining -= 1
        }
        
        updateTimerData()
        delegate?.onTimerTick(timerData: timerData)
    }
    
    private func callOnAction() {
        updateTimerData()
        delegate?.onTimerAction(timerData: timerData)
    }
    
    private func updateTimerData() {
        timerData = TimerData(total: total, remaining: remaining, status: timerStatus)
    }
    
}
