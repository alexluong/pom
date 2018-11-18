//
//  Timer.swift
//  pom
//
//  Created by Alex Luong on 11/18/18.
//  Copyright © 2018 Alex Luong. All rights reserved.
//

import Foundation

protocol CountdownServiceDelegate {
    func onTick(total: Int, remaining: Int)
}

class CountdownService {
    
    var total = 0
    var remaining = 0
    var timer: Timer!
    
    var delegate: CountdownServiceDelegate?
    
    public func setTime(seconds: Int) {
        total = seconds
    }
    
    public func start() {
        remaining = total
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(tick(timer:)),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    @objc private func tick(timer: Timer) {
        print(remaining)
        delegate?.onTick(total: total, remaining: remaining)
        remaining -= 1
    }
}
