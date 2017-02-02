//
//  CenterViewController.swift
//  swipe-navigation
//
//  Created by Donald Lee on 29/6/16.
//  Copyright © 2016 Donald Lee. All rights reserved.
//

import UIKit
import SpriteKit

class MatchViewController: EmbeddedViewController {
    
    var background: SKView!
    
    override func viewDidLoad() {
        background = SKView(frame: self.view.frame)
        let background_scene = SKScene(fileNamed: "DynamicBackgroundScene")
        background_scene?.size = self.view.frame.size
        background.presentScene(background_scene)
        self.view.addSubview(background)
        
        self.view.sendSubview(toBack: background)
        
    }
 
    @IBAction fileprivate func onTopButton(_ sender: UIButton) {
        delegate?.onShowContainer(.top, sender: sender)
    }
    
    
    @IBAction fileprivate func onLeftButton(_ sender: UIButton) {
        delegate?.onShowContainer(.left, sender: sender)
    }
    
    @IBAction fileprivate func onRightButton(_ sender: UIButton) {
        delegate?.onShowContainer(.right, sender: sender)
    }
}
