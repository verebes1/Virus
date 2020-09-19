//
//  CountdownLabel.swift
//  Virus
//
//  Created by verebes on 24/08/2020.
//  Copyright © 2020 David V. All rights reserved.
//

import Cocoa

protocol CountdownLabelDelegate {
    func moveAddTimeButton()
    func countdownFinished()
}

class CountdownLabel: NSTextField {
    
    var countdownTimer: Timer!
    var seconds = 120
    
    var countDownDelegate: CountdownLabelDelegate?
    
    
    init(title: String, seconds: Int) {
        super.init(frame: NSRect.zero)
        stringValue = title
        self.seconds = seconds
        isEditable = false
        isSelectable = false
        isBezeled = false
        drawsBackground = false
        font = NSFont.systemFont(ofSize: 45, weight: .semibold)
        translatesAutoresizingMaskIntoConstraints = false
        alignment = .center
        
        //Sets the width and the height of the label to be the initial size of its contents
        heightAnchor.constraint(equalToConstant: self.intrinsicContentSize.height).isActive = true
        widthAnchor.constraint(equalToConstant: self.intrinsicContentSize.width + 20).isActive = true
        startTimer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    MARK:- TIMER SETTING FUNCTIONS
    func startTimer() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime() {
        stringValue = "\(timeFormatted(seconds))"
        
        if countDownDelegate != nil && seconds % 5 == 0 {
            self.countDownDelegate?.moveAddTimeButton()
        }
        
        if seconds != 0 {
            seconds -= 1
        } else {
            endTimer()
        }
    }
    
    func endTimer() {
        countdownTimer.invalidate()
        countDownDelegate?.countdownFinished()
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
//        let hours: Int = totalSeconds / 3600
//        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
}
