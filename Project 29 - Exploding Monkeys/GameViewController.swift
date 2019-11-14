//
//  GameViewController.swift
//  Project 29 - Exploding Monkeys
//
//  Created by Sean Williams on 12/11/2019.
//  Copyright © 2019 Sean Williams. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    var currentGame: GameScene?
    
    @IBOutlet var angleSlider: UISlider!
    @IBOutlet var angleLabel: UILabel!
    @IBOutlet var velocitySlider: UISlider!
    @IBOutlet var velocityLabel: UILabel!
    @IBOutlet var playerNumber: UILabel!
    @IBOutlet var launchButton: UIButton!
    @IBOutlet var windSpeedLabel: UILabel!
    
    @IBOutlet var player1ScoreLabel: UILabel!
    @IBOutlet var player2ScoreLabel: UILabel!
    
    var player1Score = 0 {
        didSet {
            player1ScoreLabel.text = "P1 Score: \(player1Score)"
        }
    }
    var player2Score = 0 {
        didSet {
            player2ScoreLabel.text = "P2 Score: \(player2Score)"
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
                
                // Establish communication between view controller and game scene
                currentGame = scene as? GameScene
                currentGame?.viewController = self
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
        
        angleChanged(self)
        velocityChanged(self)
        
        player1ScoreLabel.text = "P1 Score: 0"
        player2ScoreLabel.text = "P2 Score: 0"
        
        let windSpeed = Int.random(in: -4 ... 4)
        currentGame?.physicsWorld.gravity = CGVector(dx: windSpeed, dy: -8)
        if windSpeed > 0 {
            windSpeedLabel.text = "[WIND SPEED]\n \(windSpeed * 10) MPH Eastbound"
        } else if windSpeed < 0 {
            windSpeedLabel.text = "[WIND SPEED]\n \(abs(windSpeed * 10)) MPH Westbound"
        } else {
            windSpeedLabel.text = "[WIND SPEED]\n \(windSpeed)"
        }
        
        print(windSpeed)
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

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    @IBAction func angleChanged(_ sender: Any) {
        angleLabel.text = "Angle: \(Int(angleSlider.value))°"
        
    }
    
    @IBAction func velocityChanged(_ sender: Any) {
        velocityLabel.text = "Velocity: \(Int(velocitySlider.value))"
    }
    
    @IBAction func launch(_ sender: Any) {
        angleSlider.isHidden = true
            angleLabel.isHidden = true

            velocitySlider.isHidden = true
            velocityLabel.isHidden = true

            launchButton.isHidden = true

            currentGame?.launch(angle: Int(angleSlider.value), velocity: Int(velocitySlider.value))
        
    }
    
    
    func activatePlayer(number: Int) {
        if number == 1 {
            playerNumber.text = "<<< PLAYER ONE"
        } else {
            playerNumber.text = "PLAYER TWO >>>"
        }

        angleSlider.isHidden = false
        angleLabel.isHidden = false

        velocitySlider.isHidden = false
        velocityLabel.isHidden = false

        launchButton.isHidden = false
    }
    
    

}
