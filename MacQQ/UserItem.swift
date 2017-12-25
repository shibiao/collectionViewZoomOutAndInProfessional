//
//  UserItem.swift
//  MacQQ
//
//  Created by sycf_ios on 2017/12/15.
//  Copyright © 2017年 sycf_ios. All rights reserved.
//

import Cocoa

class UserItem: NSCollectionViewItem {
    @IBOutlet weak var imageButton: LoginImageButton!
    var model: UserItemModel! {
        didSet {
            self.imageButton.image = NSImage(named: NSImage.Name(rawValue: model.name))
        }
    }
    typealias userBlcok = (_ sender: Any) -> Void
    var block: userBlcok?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    @IBAction func handleImageButtonEvent(_ sender: Any) {
        if let block = block {
            block(sender)
        }
    }
    
}
