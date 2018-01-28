//
//  MazeTools.swift
//  YCLMazeTools
//
//  Created by Marcelo Paredes on 1/23/18.
//  Copyright © 2018 Yurai.CL. All rights reserved.
//

import UIKit
import SceneKit

public class MazeTools: NSObject {
    // MARK: internal variables
    var name: String!
    var width: Int!
    var height: Int!
    var depth: CGFloat!

    // MARK: initializers

    public override init() {
        super.init()
    }

    public convenience init(name: String, width: Int, height: Int, depth: CGFloat) {
        self.init()
        self.name = name
        self.width = width
        self.height = height
        self.depth = depth
    }

    // MARK: make 3d maze

    public func make3Dmaze(name:String, cellGroups: [[Int]]) -> SCNScene {
        let result = SCNScene()
        let root = result.rootNode
        root.name = name
        root.addChildNode(self.makeFloor(name: "floor"))
        root.addChildNode(self.makeBorder(name: "border"))
        root.addChildNode(self.makeCamera(name: "camera"))
        root.addChildNode(self.makeOmniLight(name: "omniLight"))
        root.addChildNode(self.makeAmbientLight(name: "ambientLight"))
        root.addChildNode(self.makeMaze(name: "maze", cellGroups: cellGroups))
        result.background.contents = UIColor.black
        return result;
    }

    // MARK: auxiliary methods and functions
    func makeMaze(name: String, cellGroups: [[Int]]) -> SCNNode {
        let maze = SCNNode()
        maze.position = SCNVector3(0,0,0)
        maze.rotation = SCNVector4(0,0,0,0)
        maze.name = "maze"
        for group:[Int] in (cellGroups) {
            for cell:Int in (group) {
                let cellNode = makeCellNode(cell: cell, width: self.width, height: self.height, depth: self.depth)
                maze.addChildNode(cellNode)
            }
        }
        return maze.flattenedClone()
    }


    func makeOmniLight(name: String) -> SCNNode {
        let lightNode = SCNNode()
        lightNode.position = SCNVector3(x: 0.0, y: Float(2 * self.width * self.height), z: 0.0)
        lightNode.name = name
        lightNode.light = SCNLight()
        lightNode.light!.type = .omni
        return lightNode;
    }

    func makeAmbientLight(name: String) -> SCNNode {
        let lightNode = SCNNode()
        lightNode.position = SCNVector3(x: 0.0, y: Float(2 * self.width * self.height), z: 0.0)
        lightNode.name = name
        lightNode.light = SCNLight()
        lightNode.light!.type = .ambient
        return lightNode;
    }

    func makeCamera(name: String) -> SCNNode {
        let cameraNode = SCNNode()
        let camera = SCNCamera()
        cameraNode.camera = camera
        cameraNode.position = SCNVector3(0,self.width + self.height,0)
        cameraNode.eulerAngles = SCNVector3(-Double.pi / 2.1, 0, 0)
        return cameraNode
    }


    func makeFloor(name: String) -> SCNNode {
        let floor = SCNFloor()
        let result = SCNNode(geometry: floor)
        result.position = SCNVector3(x: 0, y: -0.0001, z: 0)
        result.rotation = SCNVector4(0,0,0,0)
        result.name = name
        floor.firstMaterial?.diffuse.contents = UIColor.black
        return result
    }

    func makeBorder(name: String) -> SCNNode {
        let node = SCNNode()
        node.name = name
        node.position = SCNVector3(x: 0, y: 0, z: 0)
        node.rotation = SCNVector4(0,0,0,0)
        let w2 = self.width + 2
        let h2 = self.height + 2
        let w21 = w2 - 1
        let h21 = h2 - 1
        for  n in ( 1...self.width) {
            let celln = self.makeCellNode(cell: n, width: w2, height: h2, depth: self.depth)
            celln.geometry?.firstMaterial?.transparency = 0.5
            celln.geometry?.firstMaterial?.diffuse.contents = UIColor.yellow
            let cellm = self.makeCellNode(cell: n + w2 * h21, width: w2, height: h2, depth: self.depth)
            cellm.geometry?.firstMaterial?.transparency = 0.5
            cellm.geometry?.firstMaterial?.diffuse.contents = UIColor.yellow
            node.addChildNode(celln)
            node.addChildNode(cellm)
        }
        for  n in ( 0...h21) {
            let celln = self.makeCellNode(cell: n * w2, width: w2, height: h2, depth: self.depth)
            celln.geometry?.firstMaterial?.transparency = 0.5
            celln.geometry?.firstMaterial?.diffuse.contents = UIColor.yellow
            let cellm = self.makeCellNode(cell: w21 + n * w2, width: w2, height: h2, depth: self.depth)
            cellm.geometry?.firstMaterial?.transparency = 0.5
            cellm.geometry?.firstMaterial?.diffuse.contents = UIColor.yellow
            node.addChildNode(celln)
            node.addChildNode(cellm)
        }
        return node.flattenedClone()
    }

    func makeCellNode(cell: Int, width: Int, height: Int, depth: CGFloat) -> SCNNode {
        let box = SCNBox(width: depth, height: depth, length: depth, chamferRadius: depth / 10.0)
        let node = SCNNode(geometry: box)
        let cellCenter = makeXYFromCellNo(cell: cell, width: width, height: height, depth: depth)
        node.position = SCNVector3(x: Float(cellCenter.x), y: /*Float(self.depth / 2)*/ 0.5 , z: Float(cellCenter.y))
        node.rotation = SCNVector4(0,0,0,0)
        node.name = "cell:\(cell)"
        box.firstMaterial?.diffuse.contents = UIColor.red
        return node
    }

    func makeXYFromCellNo(cell: Int, width: Int, height: Int, depth: CGFloat) -> CGPoint {
        let ix0 = CGFloat(Int(cell % width))
        let iy0 = CGFloat(Int(cell / width))
        let x0 = ix0 - (CGFloat(width) - /*depth*/ 0.5) / 2
        let y0 = iy0 - (CGFloat(height) - /*depth*/ 0.5) / 2

        let result = CGPoint(x: x0, y: y0)
        return result
    }
}

extension SCNScene {
    public func write3DMaze(basePath: String) {
        self.write(to: URL(fileURLWithPath: basePath + self.rootNode.name! + ".scn"), options: [:], delegate: nil, progressHandler: nil)
    }
}


