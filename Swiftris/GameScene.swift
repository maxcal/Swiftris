//
//  GameScene.swift
//  Swiftris
//
//  Created by Max Calabrese on 29/10/14.
//  Copyright (c) 2014 maxcal. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {

    required init(coder aDecoder: (NSCoder!)){
     fatalError("NSCoder not supported")
    }
    
    // -> void()?
    override init(size: CGSize) {
        super.init(size: size)
        // 0, 0 in SpriteKit is the bottom-left corner.
        // Swiftris will be drawn from the top down so therefore we anchor our game in the top-left corner of the screen
        anchorPoint = CGPoint(x: 0, y: 1.0)
        // SKSpriteNode capable of representing our background image
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 0, y: 0)
        background.anchorPoint = CGPoint(x: 0, y: 1.0)
        // Attach to scene
        addChild(background)
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
