//
//  CircleButton.swift
//  Virus
//
//  Created by verebes on 21/07/2020.
//  Copyright © 2020 David V. All rights reserved.
//

import Cocoa

class CircleButton: StandardButton {
    
//    var leftConstraint: NSLayoutConstraint
//    var topConstraint: NSLayoutConstraint
    
    init(title: String) {
//        leftConstraint = NSLayoutConstraint()
//        topConstraint = NSLayoutConstraint()
        super.init(frame: NSRect.zero)
        self.title = title
        font = NSFont(name: "Avenir", size: 15)
        wantsLayer = true
        layer?.cornerRadius = 25
        layer?.masksToBounds = true
        layer?.backgroundColor = NSColor.systemRed.cgColor
        layer?.borderColor = NSColor.systemRed.cgColor
        layer?.borderWidth = 2
        alphaValue = 0.75
//        isHidden = true
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

//        let path = NSBezierPath(ovalIn: dirtyRect)
//        NSColor.systemRed.setFill()
//        path.fill()
    }
    
}
