//
//  Array2D.swift
//  Swiftris
//
//  Created by Max Calabrese on 29/10/14.
//  Copyright (c) 2014 maxcal. All rights reserved.
//

// Generic arrays in Swift are actually of type struct, not class but we need a class in this case since class objects are 
// passed by reference whereas structures are passed by value (copied).
// Our game logic will require a single copy of this data structure to persist across the entire game.
// Notice that in the class' declaration we provide a typed parameter: <T>. 
// This allows our array to store any type of data and therefore remain a general-purpose tool.
class ArrayTD<T> {
    let columns : Int
    let rows : Int
    
    // the underlying data structure which maintains references to our objects.
    // nil locations found on our game board will represent empty spots where no block is present.
    var array: Array<T?>
   
    init(columns: Int, rows: Int) {
        self.columns = columns
        self.rows = rows
        // we instantiate our internal array structure with a size of rows * columns. 
        // This guarantees that Array2D can store as many objects as our game board requires, 200 in our case.
        array = Array<T?>(count:rows * columns, repeatedValue: nil)
    }
    //  subscript capable of supporting array[column, row]
    subscript(column: Int, row: Int) -> T? {
        get {
            return array[row * columns + column]
        }
        set(newValue) {
            array[row * columns + column] = newValue
        }
    }
}