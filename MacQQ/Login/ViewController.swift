//
//  ViewController.swift
//  MacQQ
//
//  Created by sycf_ios on 2017/12/15.
//  Copyright © 2017年 sycf_ios. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    var usersData = Array<String>()
    @IBOutlet weak var collectionView: NSCollectionView!
    var  subWindow: NSWindow?
    lazy var transitionItem: LoginImageButton = {
        let button = LoginImageButton()
//        button.imageScaling = .scaleAxesIndependently
        button.target = self
        button.action = #selector(handleButtonClick(_:))
        button.isBordered = false
//        button.layer?.backgroundColor = NSColor.white.cgColor
        return button
    }()
    var rect: NSRect?
    override func viewDidLoad() {
        super.viewDidLoad()
        usersData = [
        "avatar",
        "avatar2",
        "avatar",
        "avatar2",
        "add"
        ]
        collectionView.register(NSNib.init(nibNamed: NSNib.Name.init("UserItem"), bundle: nil), forItemWithIdentifier: NSUserInterfaceItemIdentifier.init("UserItem"))
        
    }
    @objc func handleButtonClick(_ sender: LoginImageButton) {
        NSAnimationContext.runAnimationGroup({ (context) in
            context.duration = 0.5
            context.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            self.transitionItem.animator().frame = rect!
        }) {
            self.collectionView.isHidden = false
            self.transitionItem.removeFromSuperview()
        }
    }

    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if segue.identifier?.rawValue == "show" {
            self.view.window?.close()
        }
    }
    override func viewWillAppear() {
        super.viewWillAppear()
        let indexPath = IndexPath(item: 0, section: 0)
        let firstItem = self.collectionView.item(at: indexPath) as! UserItem
        rect = self.view.convert(firstItem.view.frame, from: self.collectionView)
        self.transitionItem.frame = rect!
        self.transitionItem.image = NSImage(named: NSImage.Name.init(usersData[indexPath.item]))
        collectionView.isHidden = true
        self.view.addSubview(transitionItem)
        var tmpFrame = NSMakeRect(124, 0, 100, 100)
        //            tmpFrame = self.collectionView.convert(tmpFrame, from: self.view)
        tmpFrame = self.view.convert(tmpFrame, to: self.collectionView)
        //            tmpFrame = self.collectionView.convert(tmpFrame, to: self.collectionView)
        self.transitionItem.frame = tmpFrame
        self.transitionItem.imageScaling = .scaleAxesIndependently

    }
    override func viewDidAppear() {
        super.viewDidAppear()
        self.subWindow = NSWindow(contentRect: NSMakeRect((self.view.window?.frame.origin.x)!,
                                                          (self.view.window?.frame.origin.y)!+80,
                                                          (self.view.window?.frame.size.width)!,
                                                          0), styleMask: [.titled], backing: NSWindow.BackingStoreType.buffered, defer: true)
        let settingVC = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil).instantiateController(withIdentifier: NSStoryboard.SceneIdentifier.init(rawValue: "settingVC")) as! NSWindowController
//        self.subWindow?.isMovableByWindowBackground = true
        self.subWindow?.backgroundColor = .white
        self.subWindow?.animator().contentViewController = settingVC.contentViewController
        
        
        view.window?.animator().addChildWindow(self.subWindow!, ordered: .below)
        print(NSStringFromRect(self.collectionView.frame))
    }
    @IBAction func handleClose(_ sender: Any) {
        NSApp.terminate(sender)
//        NSApplication.shared.terminate(sender)
//        NSApp 等于 NSApplication.shared
//        错误的写法：NSApplication.terminate(sender)
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    @IBAction func handleSubWindow(_ sender: Any) {
        let sender = sender as! NSButton
       subWindow?.becomeKey()
        NSAnimationContext.runAnimationGroup({ (context) in
            context.duration = 0.5
            context.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            if sender.state == .on {
                self.subWindow?.animator().setFrame(NSMakeRect((self.view.window?.frame.origin.x)!,
                                                    (self.view.window?.frame.origin.y)!-78,
                                                    (self.view.window?.frame.size.width)!,
                                                    100), display: true)
                
                view.window?.animator().addChildWindow(self.subWindow!, ordered: .below)
            }else {
                if  self.subWindow != nil {
                    view.window?.removeChildWindow(self.subWindow!)
                    self.subWindow?.animator().setFrame(NSMakeRect((self.view.window?.frame.origin.x)!, ((self.view.window?.frame.origin.y)!+22), (self.view.window?.frame.width)!, 0), display: false)
                }
            }
        }, completionHandler: nil)
       
    }
    

}
extension ViewController: NSCollectionViewDataSource,NSCollectionViewDelegate {
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {

        return usersData.count
    }
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier.init("UserItem"), for: indexPath) as! UserItem
        item.model = UserItemModel(name: usersData[indexPath.item])
        item.delegate = self
        item.block = { [weak self](sender) -> Void in
            if let weakSelf = self {
                weakSelf.handleItem(item, with: indexPath)
            }
            
        }
        return item
    }
    func handleItem(_ item: UserItem,with indexPath: IndexPath) {
        rect = self.view.convert(item.view.frame, from: self.collectionView)
        self.transitionItem.frame = rect!
        self.transitionItem.image = NSImage(named: NSImage.Name.init(usersData[indexPath.item]))
        collectionView.isHidden = true
        self.view.addSubview(transitionItem)
        NSAnimationContext.runAnimationGroup({ (context) in
            context.duration = 0.5
            context.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            var tmpFrame = NSMakeRect(124, 0, 100, 100)
            tmpFrame = self.view.convert(tmpFrame, to: self.collectionView)
            self.transitionItem.animator().frame = tmpFrame
            
        }, completionHandler: nil)
    }
}
extension ViewController: UserItemDelegate {
    func userItem(_ item: UserItem, didClick button: NSButton) {
        if let indexPath = collectionView.indexPath(for: item) {
            collectionView.deleteItems(at: [indexPath])
            usersData.remove(at: indexPath.item)
            collectionView.reloadData()
        }
       
        
    }
    
    
}
    

