//
//  Block.swift
//  Swiftris
//
//  Created by Max Calabrese on 29/10/14.
//  Copyright (c) 2014 maxcal. All rights reserved.
//

import SpriteKit


let NumberOfColors: UInt32 = 6

// implements the Printable protocol.
enum BlockColor: Int, Printable {
    //  the full list of enumerable options, one for each color
    case Blue = 0, Orange, Purple, Red, Teal, Yellow
    
    // Block is invoked to generate spriteName value each time.
    // We could have put this inside of a function named, getSpriteName() 
    // but a computed property is the better design choice. [why?]
    // My comment: I would have just used a Dict. instead of a switch and made it passable.
    var spriteName: String {
        switch self {
        case .Blue:
            return "blue"
        case .Orange:
            return "orange"
        case .Purple:
            return "purple"
        case .Red:
            return "red"
        case .Teal:
            return "teal"
        case .Yellow:
            return "yellow"
        }
    }

    // required if we are to adhere to the Printable protocol. 
    // It simply returns the spriteName of the color which is more than enough to describe the object.
    var description: String {
        return self.spriteName
    }

    /**
    * returns a random choice among the colors found in BlockColor
    */
    static func random() -> BlockColor {
        var rand : Int = Int(arc4random_uniform(NumberOfColors))
        // this differs from tutorial since `.fromRaw` is replaced with a failable init
        return BlockColor(rawValue: rand)!
    }
}

/**
* Printable gives custom textual representation
* Hashable allows Block to be stored in Array2D
*/
class Block: Hashable, Printable {
    // A block should not be able to change colors mid-game unless you decide 
    // to make Swiftris: Epileptic Adventures. LOL
    let color: BlockColor
    // These properties represent the location of the Block on our game board.
    var column: Int
    var row: Int
    // represents the visual element of the Block to be used by GameScene 
    // when rendering and animating each Block.
    var sprite: SKSpriteNode?
    // required to comply with printable
    var description : String {
        return "\(color): [\(column), \(row)]"
    }
    // required in order to support Hashable
    var hashValue: Int {
        return self.column ^ self.row
    }
    init (column: Int, row: Int, color: BlockColor) {
        self.row = row
        self.column = column
        self.color = color
    }
}
// custom operator- == - for comparing one Block with another
// aparently they are done at global scope and not within the class definition
func ==(lhs: Block, rhs: Block) -> Bool {
    return lhs.column == rhs.column && lhs.row == rhs.row && lhs.color.rawValue == rhs.color.rawValue
}