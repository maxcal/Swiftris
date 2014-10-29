//
//  GameScene.swift
//  Swiftris
//
//  Created by Max Calabrese on 29/10/14.
//  Copyright (c) 2014 maxcal. All rights reserved.
//

import SpriteKit

let TickLengthLevelOne = NSTimeInterval(600)

class GameScene: SKScene {
    
    var tick:(() -> ())? // A closure
    var tickLengthMillis = TickLengthLevelOne // the GameScene's current tick length
    var lastTick:NSDate? //

    required init(coder aDecoder: (NSCoder!)){
     fatalError("NSCoder not supported")
    }
    
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
        
        if lastTick == nil {
            return // since we are in a paused state, not reporting elapsed ticks to anyone
        }
        // The time passed since the last execution of update.
        // We multiply the result by -1000 in order to get a positive millisecond value.
        var timePassed = lastTick!.timeIntervalSinceNow * -1000.0
        
        //  If enough time has elapsed, we must report a tick.
        if timePassed > tickLengthMillis {
            lastTick = NSDate() // NSDate.date call in tutorial is unavailble
            tick?()
        }
    }
    
    func startTicking() {
        lastTick = NSDate()
    }
    
    func stopTicking() {
        lastTick = nil
    }
}
