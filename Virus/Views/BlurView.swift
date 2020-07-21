//
//  BlurView.swift
//  Virus
//
//  Created by verebes on 20/07/2020.
//  Copyright © 2020 David V. All rights reserved.
//

import Cocoa

class BlurView: NSVisualEffectView {
    
    //can be used as a reusable component in programmatic approach
    override init(frame frameRect: NSRect) {
        super .init(frame: frameRect)
        blendingMode = .behindWindow
        material = .fullScreenUI
        state = .active
        identifier = .init("background_blur")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        print("DRAW DIRTYRECT CALLED")
    }
}
