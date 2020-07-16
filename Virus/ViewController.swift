//
//  ViewController.swift
//  Virus
//
//  Created by verebes on 07/11/2019.
//  Copyright © 2019 David V. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    @IBOutlet weak var buttonTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var buttonLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var deactivateButton: NSButton!
    @IBOutlet weak var countdownLabel: NSTextField!
    @IBOutlet weak var messageLabel: NSTextField!
    
    var countdownTimer: Timer!
    var seconds = 120
    
    //480 x 270 - Initial frame size and minimum frame size of the app.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addButtonMouseOverTracking(button: deactivateButton) // add tracking area to deactivate button
        startTimer()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
//    Adds button frame tracking area for the mouse in order to check if mouse has entered the buttons frame
    private func addButtonMouseOverTracking(button: NSButton) {
        let area = NSTrackingArea.init(rect: button.bounds, options: [NSTrackingArea.Options.mouseEnteredAndExited, NSTrackingArea.Options.activeAlways], owner: self, userInfo: nil)
        button.addTrackingArea(area)
    }
    
    //MARK:- MOVE BUTTON RANDOMLY WHEN ENTERING BUTTONS FRAME
    override func mouseEntered(with event: NSEvent) {
//        print("ENTERED BUTTON FRAME")
        moveButtonRandomly()
    }
        
    override func mouseExited(with event: NSEvent) {
//        print("EXITED BUTTON FRAME")
    }
    
    private func moveButtonRandomly() {
        let width = UInt32(view.bounds.width) - 90
        let height = UInt32(view.bounds.height) - 25
        print("WIDTH IS: \(width + 90), HEIGHT IS: \(height + 25)")
        //480 x 270
        let leftConstraintValue = CGFloat(arc4random_uniform(width))// + 90
        let topConstraintValue = CGFloat(arc4random_uniform(height))// + 25
//        while leftConstraintValue < width 
        buttonLeftConstraint.constant = leftConstraintValue
        buttonTopConstraint.constant = topConstraintValue
        print("Button position from left = \(buttonLeftConstraint.constant)")
        print("Button position from top = \(buttonTopConstraint.constant)")

    }

//    MARK:- TIMER SETTING FUNCTIONS
    func startTimer() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }

    @objc func updateTime() {
        countdownLabel.stringValue = "\(timeFormatted(seconds))"

        if seconds != 0 {
            seconds -= 1
        } else {
            endTimer()
        }
    }

    func endTimer() {
        countdownTimer.invalidate()
        messageLabel.stringValue = "Your files have been encrypted....."
    }

    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
//        let hours: Int = totalSeconds / 3600
        return String(format: "%02d:%02d", minutes, seconds)
    }

    
    
    
//    MARK:- DEACTIVATE THE TIMER AND SHOW A HAPPY MESSAGE
    @IBAction func deactivateTapped(_ sender: NSButton) {
        messageLabel.stringValue = "You cannot turn the timer off. Sorry :)"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.messageLabel.stringValue = "Your files will be infected and encrypten in:"
        }
    }
    
}

