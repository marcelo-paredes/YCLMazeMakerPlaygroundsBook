//  Created by Marcelo Paredes on 1/23/18.
//  Copyright © 2018, Marcelo Paredes, Yurai.CL. All rights reserved.
/*:
    Mazes Example

    The code below creates a n*m mazegenerator, and with it
    it makes a sample maze by telling arrays of arrays of cells.

    The cell lists are numbers from 0 to m * n - 1, where they are
    counted from left to right, top to bottom.
 */
//: [Previous](@previous)

import UIKit
import SceneKit
import PlaygroundSupport


let t: MazeTools = MazeTools(name: "tools3x3", width: 3, height: 3, depth: 0.8)
let mazeScene = t.make3Dmaze(name: "sample1", cellGroups: [[0,3,6], [2,5,8]])

let mazeViewController = MazeViewController()
mazeViewController.scene = mazeScene

PlaygroundPage.current.liveView = mazeViewController.sceneView
PlaygroundPage.current.needsIndefiniteExecution = true


