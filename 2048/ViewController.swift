//
//  ViewController.swift
//  2048
//
//  Created by yky on 22/06/2017.
//  Copyright © 2017 yky. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let btnWidth : CGFloat = 100.0
    
    @IBOutlet weak var startGameBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        let x : CGFloat = (view.bounds.size.width - btnWidth) / 2
        let y : CGFloat = (view.bounds.size.height - btnWidth) / 2
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor(red: 0.16, green: 0.52, blue: 0.80, alpha: 0.5)
        startGameBtn.frame = CGRect(x: x, y: y, width: btnWidth, height: btnWidth)
        startGameBtn.layer.cornerRadius = 50
        //[UIColor colorWithRed:0.14 green:0.18 blue:0.22 alpha:1.00]
        startGameBtn.backgroundColor = UIColor(red: 0.14, green: 0.18, blue: 0.22, alpha: 0.8)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startGame(_ sender: UIButton) {
        let game = GameController()
        present(game, animated: true , completion: nil)
    }
}

