//
//  MainViewController.swift
//  collectionViewZoomOutAndInProfessional
//
//  Created by sycf_ios on 2017/12/26.
//  Copyright © 2017年 sycf_ios. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController {
    
    @IBOutlet weak var leftSideView: NSView!
    @IBOutlet weak var mainSplitView: SBSplitView!
    override func viewDidLoad() {
        super.viewDidLoad()
        mainSplitView.setPosition(150, ofDividerAt: 0)
        
    }
    

}
extension MainViewController: NSSplitViewDelegate {
    func splitView(_ splitView: NSSplitView, constrainMinCoordinate proposedMinimumPosition: CGFloat, ofSubviewAt dividerIndex: Int) -> CGFloat {
        return 100
    }
    func splitView(_ splitView: NSSplitView, constrainMaxCoordinate proposedMaximumPosition: CGFloat, ofSubviewAt dividerIndex: Int) -> CGFloat {
        return 200
    }
    func splitView(_ splitView: NSSplitView, resizeSubviewsWithOldSize oldSize: NSSize) {
        splitView.setPosition(leftSideView.frame.width, ofDividerAt: 0)
//        print(splitView.minPossiblePositionOfDivider(at: 0))
    }
    func splitViewWillResizeSubviews(_ notification: Notification) {
        
    }
    func splitViewDidResizeSubviews(_ notification: Notification) {
        
    }
}
