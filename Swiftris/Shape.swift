
//
//  Shape.swift
//  Swiftris
//
//  Created by Max Calabrese on 29/10/14.
//  Copyright (c) 2014 maxcal. All rights reserved.
//

import SpriteKit

let NumOrientations: UInt32 = 4

enum Orientation: Int, Printable {

    case Zero = 0, Ninety, OneEighty, TwoSeventy
    
    var description: String {
        switch self {
        case .Zero:
            return "0"
        case .Ninety:
            return "90"
        case .OneEighty:
            return "180"
        case .TwoSeventy:
            return "270"
        }
    }
    
    static func random() -> Orientation {
        return Orientation(rawValue: Int(arc4random_uniform(NumOrientations)))!
    }
    
    static func rotate(orientation:Orientation, clockwise: Bool) -> Orientation {
        var rotated = orientation.rawValue + (clockwise ? 1 : -1)
        if rotated > Orientation.TwoSeventy.rawValue {
            rotated = Orientation.Zero.rawValue
        } else if rotated < 0 {
            rotated = Orientation.TwoSeventy.rawValue
        }
        
        return Orientation(rawValue: rotated)!
    }
}

// The number of total shape varieties
let NumShapeTypes: UInt32 = 7

// Shape indexes
let FirstBlockIdx: Int = 0
let SecondBlockIdx: Int = 1
let ThirdBlockIdx: Int = 2
let FourthBlockIdx: Int = 3

class Shape: Hashable, Printable {
    
    let color:BlockColor
    // The blocks comprising the shape
    var blocks = Array<Block>()
    // The current orientation of the shape
    var orientation : Orientation
    // The column and row representing the shape's anchor point
    var column, row: Int
    // required by Printable
    var description: String {
        return "\(color) block facing \(orientation): \(blocks[FirstBlockIdx]), \(blocks[SecondBlockIdx]), \(blocks[ThirdBlockIdx]), \(blocks[FourthBlockIdx])"
    }
    // required by Hashable
    var hashValue : Int {
        return reduce(blocks, 0) { $0.hashValue ^ $1.hashValue }
    }
    // Required Overrides
    
    // Subclasses must override this property
    var blockRowColumnPositions: [Orientation: Array<(columnDiff: Int, rowDiff: Int)>] {
        return [:]
    }
    
    // Subclasses must override this property
    var bottomBlocksForOrientations: [Orientation: Array<Block>] {
        return [:]
    }
    
    var bottomBlocks:Array<Block> {
        if let bottomBlocks = bottomBlocksForOrientations[orientation] {
            return bottomBlocks
        }
        return []
    }
    
    init(column: Int, row: Int, color: BlockColor, orientation: Orientation){
        self.color = color
        self.column = column
        self.row = row
        self.orientation = orientation
    }
    /**
    * assigns the given row and column values while generating a random color and a random orientation.
    */
    convenience init(column:Int, row:Int) {
        self.init(column:column, row:row, color:BlockColor.random(), orientation: Orientation.random())
    }
}

func ==(lhs: Shape, rhs: Shape) -> Bool {
    return lhs.row == rhs.row && lhs.column == rhs.column
}

