//
//  MatchViewController.swift
//  Geist
//
//  Created by Jose Eduardo Quintero Gutiérrez on 01/02/17.
//  Copyright © 2017 Jose Eduardo Quintero Gutiérrez. All rights reserved.
//

import UIKit
import SpriteKit

class MatchViewController: EmbeddedViewController {
    
    @IBOutlet var background: SKView!
    
    override func viewDidLoad() {
        
        //Adding particles background
        
        let background_scene = SKScene(fileNamed: "DynamicBackgroundScene")
        background_scene?.size = self.view.frame.size
        background.presentScene(background_scene)
        background_scene?.backgroundColor = .clear
        background.allowsTransparency = true
        
        let smoke: SKEmitterNode = SKEmitterNode(fileNamed: "Smoke.sks")!
        background_scene?.addChild(smoke)
        
        //self.view.addSubview(background)
        //self.view.sendSubview(toBack: background)
        
    }
 

}
