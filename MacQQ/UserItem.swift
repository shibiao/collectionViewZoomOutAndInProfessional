//
//  UserItem.swift
//  MacQQ
//
//  Created by sycf_ios on 2017/12/15.
//  Copyright © 2017年 sycf_ios. All rights reserved.
//

import Cocoa
protocol UserItemDelegate: class {
    func userItem(_ item: UserItem, didClick button: NSButton)
}
class UserItem: NSCollectionViewItem {
    @IBOutlet weak var closeButton: NSButton!
    
    @IBOutlet weak var imageButton: LoginImageButton!
    
    var delegate: UserItemDelegate?
    var model: UserItemModel! {
        didSet {
            self.imageButton.image = NSImage(named: NSImage.Name(rawValue: model.name))
        }
    }
    typealias userBlcok = (_ sender: Any) -> Void
    var block: userBlcok?
    override func viewDidLoad() {
        super.viewDidLoad()
        let trackingArea = NSTrackingArea(rect: self.view.bounds, options: [.mouseEnteredAndExited,.activeInActiveApp], owner: self, userInfo: nil)
        self.view.addTrackingArea(trackingArea)
    }
    @IBAction func handleImageButtonEvent(_ sender: Any) {
        if let block = block {
            block(sender)
        }
    }
    override func mouseEntered(with event: NSEvent) {
        closeButton.isHidden = false
    }
    override func mouseExited(with event: NSEvent) {
        closeButton.isHidden = true
    }
    @IBAction func handleClose(_ sender: Any) {
        if let delegate = delegate {
            delegate.userItem(self, didClick: sender as! NSButton)
        }
    }
    
}
