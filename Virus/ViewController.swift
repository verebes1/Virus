//
//  ViewController.swift
//  Virus
//
//  Created by verebes on 07/11/2019.
//  Copyright © 2020 David V. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, CountdownLabelDelegate {
    @IBOutlet weak var buttonTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var buttonLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var deactivateButton: StandardButton!
    @IBOutlet weak var messageLabel: NSTextField!
    
    //Declaration of the programmatic view elements
    let blurView = BlurView(frame: NSRect.zero)
    let addTimeButton = CircleButton(title: "+5")
    let countdownLabel = CountdownLabel(title: "02:00", seconds: 120)
    
    //480 x 270 - Initial frame size and minimum frame size of the app.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTimeButton.action = #selector(addTime)
        addButtonMouseOverTracking(button: deactivateButton) // add tracking area to deactivate button
        countdownLabel.countDownDelegate = self
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    override func viewWillLayout() {
        //Adds transparency to the app
        view.window?.isOpaque = false
        view.window?.alphaValue = 0.98
        
        //Update the frame size of the blurview
        //        print("UPDATING THE FRAME to \(view.bounds)")
        blurView.frame = view.bounds
        
        //Moves the button randomly in case it is not visible after resizing the screen
        if !view.frame.contains(deactivateButton.frame) {
            moveButtonRandomly(button: deactivateButton)
        }
        if !view.frame.contains(addTimeButton.frame) {
            moveButtonRandomly(button: addTimeButton)
        }
    }
    
    //MARK:- Keeps window on top.
    override func viewDidAppear() {
        view.window?.level = .floating
        addProgrammaticViewsSetConstraints()
    }
    
    // END MARK
    
    private func addProgrammaticViewsSetConstraints() {
        view.window?.contentView?.addSubview(countdownLabel)
        //Adds the blurView programmatically if needed instead of using storyboards
        view.window?.contentView?.addSubview(blurView, positioned: .below, relativeTo: messageLabel)
        //Adds another button programmatically which when pressed adds 5 seconds of time to the countdown
        view.window?.contentView?.addSubview(addTimeButton)
        addTimeButton.leftConstraint = NSLayoutConstraint(item: addTimeButton, attribute: .left, relatedBy: .equal, toItem: view.window?.contentView, attribute: .left, multiplier: 1.0, constant: 5)
        addTimeButton.topConstraint = NSLayoutConstraint(item: addTimeButton, attribute: .top, relatedBy: .equal, toItem: view.window?.contentView, attribute: .top, multiplier: 1.0, constant: 5)
        
        addTimeButton.leftConstraint.isActive = true
        addTimeButton.topConstraint.isActive = true
        
        if let centerXConstraint = view.window?.contentView?.centerXAnchor, let centerYConstraint = view.window?.contentView?.centerYAnchor {
            countdownLabel.centerXAnchor.constraint(equalTo: centerXConstraint).isActive = true
            countdownLabel.centerYAnchor.constraint(equalTo: centerYConstraint).isActive = true
        }
        
        deactivateButton.leftConstraint = buttonLeftConstraint
        deactivateButton.topConstraint = buttonTopConstraint
    }
    //    Adds button frame tracking area for the mouse in order to check if mouse has entered the buttons frame
    private func addButtonMouseOverTracking(button: NSButton) {
        let area = NSTrackingArea.init(rect: button.bounds, options: [NSTrackingArea.Options.mouseEnteredAndExited, NSTrackingArea.Options.activeAlways], owner: self, userInfo: nil)
        button.addTrackingArea(area)
    }
    
    //MARK:- MOVE BUTTON RANDOMLY WHEN ENTERING BUTTONS FRAME
    override func mouseEntered(with event: NSEvent) {
        //        print("ENTERED BUTTON FRAME")
        moveButtonRandomly(button: deactivateButton)
    }
    
    override func mouseExited(with event: NSEvent) {
        //        print("EXITED BUTTON FRAME")
    }
    
    private func moveButtonRandomly(button: StandardButton) {
        let btnWidth = UInt32(button.frame.width)
        let btnHeight = UInt32(button.frame.height)
        let width = UInt32(view.frame.width) - btnWidth //this is the main window width - offset for button frame
        let height = UInt32(view.frame.height) - btnHeight
        //        print("WINDOW WIDTH IS: \(width + btnWidth), HEIGHT IS: \(height + btnHeight)")
        //480 x 270 default
        let leftConstraintValue = CGFloat(arc4random_uniform(width))// + 90
        let topConstraintValue = CGFloat(arc4random_uniform(height))// + 25
        
        NSAnimationContext.runAnimationGroup({_ in
            //Indicate the duration of the animation
            NSAnimationContext.current.duration = 0.25
            button.topConstraint.animator().constant = topConstraintValue
            button.leftConstraint.animator().constant = leftConstraintValue
            //            button.animator().alphaValue = 0.75
        }, completionHandler:nil)
        
        //        print("Button position from left = \(button.leftConstraint.constant)")
        //        print("Button position from top = \(button.topConstraint.constant)")
    }
    
    private func fade(button: StandardButton, state: AnimationState) {
        NSAnimationContext.runAnimationGroup({_ in
            //Indicate the duration of the animation
            NSAnimationContext.current.duration = 0.5
            button.animator().alphaValue = state == .fadeIn ? 0.85 : 0.0
        }, completionHandler: {
            button.isHidden = state == .fadeOut ? true : false
            button.isEnabled = state == .fadeIn ? true : false
            self.moveButtonRandomly(button: button)
        })
    }
    
    //Add 5 seconds on the press of the red button
    @objc func addTime() {
        countdownLabel.seconds += 5
        addTimeButton.isEnabled = false
        fade(button: addTimeButton, state: .fadeOut)
    }
    
    
    //    MARK:- DEACTIVATE THE TIMER AND SHOW A HAPPY MESSAGE NOT
    @IBAction func deactivateTapped(_ sender: NSButton) {
        messageLabel.stringValue = "You cannot turn the timer off. Sorry :)"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.messageLabel.stringValue = "Your files will be infected and encrypten in:"
        }
    }
    
    // MARK:- COUNTDOWN LABEL DELEGATE FUNCTIONS IMPLEMENTATION
    func moveAddTimeButton() {
        fade(button: addTimeButton, state: .fadeIn)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.fade(button: self.addTimeButton, state: .fadeOut)
        }
    }
    
    func countdownFinished() {
        messageLabel.stringValue = "Your files have been encrypted....."
    }
    
}
