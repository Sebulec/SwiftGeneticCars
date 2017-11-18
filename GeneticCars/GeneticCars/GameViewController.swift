//
//  GameViewController.swift
//  GeneticCars
//
//  Created by Sebastian Kotarski on 25.10.2017.
//  Copyright © 2017 Sebastian Kotarski. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController, GameDelegate {
    var gameStats = GameStats()
    
    @IBOutlet weak var gameStatsLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") as? GameScene {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
                
                // set delegate
                scene.gameDelegate = self
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //    pragma mark - GameDelegate
    func didEndedThePopulation(with vehicles: [Vehicle: CGFloat]) {
        // todo
    }
    
    func updateGame(with vehicles: [Vehicle : CGFloat]) {
        gameStats.vehiclesWithScores = vehicles
        self.gameStatsLabel.text = gameStats.getLabelInfo()
    }
}
