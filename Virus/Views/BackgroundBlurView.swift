//
//  BackgroundBlurView.swift
//  Virus
//
//  Created by verebes on 20/07/2020.
//  Copyright © 2020 David V. All rights reserved.
//

import Cocoa

class BackgroundBlurView: NSVisualEffectView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        blendingMode = .behindWindow
        material = .fullScreenUI
        state = .active
    }
    
}
