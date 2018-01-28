//
//  MazeViewController.swift
//  YCLMazeTools
//
//  Created by Marcelo Paredes on 1/23/18.
//  Copyright © 2018 Yurai.CL. All rights reserved.
//
import UIKit
import SceneKit


public class MazeViewController: UIViewController, SCNSceneRendererDelegate {

    public var sceneView: SCNView!

    public var scene: SCNScene! {
        didSet {
            print("@ set scene")
            self.sceneView = SCNView(frame: CGRect(x: 0, y: 0, width: 600, height: 600))
            self.sceneView.delegate = self
            self.sceneView.autoenablesDefaultLighting = true
            self.sceneView.showsStatistics = true
            self.sceneView.allowsCameraControl = true
            self.sceneView.scene = self.scene
            self.sceneView.pointOfView = self.scene.rootNode.childNode(withName:"camera", recursively: false)
            self.sceneView.pointOfView  = nil
            self.sceneView.setNeedsDisplay()
        }
    }

    public override func loadView() {
        print("@ loadView")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        print("@ viewDidLoad")
    }
}
