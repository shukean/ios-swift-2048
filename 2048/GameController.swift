//
//  GameController.swift
//  2048
//
//  Created by yky on 23/06/2017.
//  Copyright © 2017 yky. All rights reserved.
//

import UIKit

protocol GameOverDelegate {
    func setGameOver()
    func setGameRestart()
}

class GameController: UIViewController, GameOverDelegate {
    
    let highScore : Int = 2048
    let boardWitdh : CGFloat = 300.0
    
    var board : Board?
    var isGameOver : Bool = false

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor(red: 0.16, green: 0.52, blue: 0.80, alpha: 1.00)
        setUpScore()
        setUpGame()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpGame() {
        
        let viewWidth = view.bounds.size.width
        let viewHeight = view.bounds.size.height
        
        //        [UIColor colorWithRed:0.24 green:0.65 blue:0.87 alpha:1.00]
        let boardBgColor = UIColor(red: 0.24, green: 0.65, blue: 0.87, alpha: 1.00)
        
        board = Board(width: boardWitdh, height: boardWitdh, backcolor: boardBgColor, gameDelegate: self)
        let boardX = (viewWidth - boardWitdh) / 2
        let boardY = (viewHeight - boardWitdh) / 2
        var f = board?.frame
        f?.origin.x = boardX
        f?.origin.y = boardY
        board?.frame = f!
        view.addSubview(board!)

        setUpSwipeEvents()
        
    }
    
    func setUpScore(){
        //[UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.00]
//        let lbColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
//        scoreTitle.textColor = lbColor
//        highScoreTitle.textColor = lbColor
//        
//        curScore.textColor = lbColor
//        curScore.adjustsFontSizeToFitWidth = true
//        higtScore.textColor = lbColor
//        higtScore.adjustsFontSizeToFitWidth = true
    }
    
    
    func setUpSwipeEvents(){
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(GameController.swipeGesture(sender:)))
        upSwipe.direction = UISwipeGestureRecognizerDirection.up
        view.addGestureRecognizer(upSwipe)
        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(GameController.swipeGesture(sender:)))
        downSwipe.direction = UISwipeGestureRecognizerDirection.down
        view.addGestureRecognizer(downSwipe)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(GameController.swipeGesture(sender:)))
        leftSwipe.direction = UISwipeGestureRecognizerDirection.left
        view.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(GameController.swipeGesture(sender:)))
        rightSwipe.direction = UISwipeGestureRecognizerDirection.right
        view.addGestureRecognizer(rightSwipe)
    }
    
    func swipeGesture(sender : UISwipeGestureRecognizer){
        if isGameOver {
            return
        }
        switch sender.direction {
        case UISwipeGestureRecognizerDirection.up:
            print("up")
            board!.move(direction: .up)
            break
        case UISwipeGestureRecognizerDirection.down:
            print("down")
            board!.move(direction: .down)

            break
        case UISwipeGestureRecognizerDirection.left:
            print("left")
            board!.move(direction: .left)
            break
        case UISwipeGestureRecognizerDirection.right:
            print("right")
            board!.move(direction: .right)
            break
        default:
            return
        }
    }
    
    func setGameOver() {
        isGameOver = true
    }
    
    func setGameRestart() {
        isGameOver = false
    }
}
