//
//  ToolBarView.swift
//  collectionViewZoomOutAndInProfessional
//
//  Created by sycf_ios on 2017/12/26.
//  Copyright © 2017年 sycf_ios. All rights reserved.
//

import Cocoa

class ToolBarView: NSView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        wantsLayer = true
        layer?.backgroundColor = NSColor.lightGray.cgColor
        
    }

}
