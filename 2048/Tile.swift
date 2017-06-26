//
//  Tile.swift
//  2048
//
//  Created by yky on 23/06/2017.
//  Copyright © 2017 yky. All rights reserved.
//

import UIKit

class Tile : UIView {
    
    //[UIColor colorWithRed:0.84 green:0.65 blue:0.87 alpha:1.00]
    let pinkColor = UIColor(red: 0.84, green: 0.65, blue: 0.87, alpha: 0.6)
    
    //[UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.00]
    let whiteColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    
    var lable : UILabel
    var width : CGFloat
    
    var value : Int = 0 {
        didSet {
            UIView.animate(withDuration: 0.1, animations: {
                self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            }, completion: {
                (finished: Bool) in
                self.lable.layer.backgroundColor = self.updateColor(value: self.value)
                self.lable.text = "\(self.value)"
                self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            })
            
        }
    }
    
    init(position pos: CGPoint, width : CGFloat, value : Int) {
        self.width = width
        lable = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: width))
        lable.textAlignment = NSTextAlignment.center
        lable.minimumScaleFactor = 0.5
        lable.textColor = whiteColor
        lable.text = "\(value)"
        lable.font = UIFont(name: "HelveticaNeue-Bold", size: 30) ?? UIFont.systemFont(ofSize: 30)
        lable.layer.backgroundColor = pinkColor.cgColor
        lable.layer.cornerRadius = 8
        super.init(frame: CGRect(x: pos.x, y: pos.y, width: width, height: width))
        addSubview(lable)
        self.value = value
    }
    
    func run(duration: TimeInterval, position: CGPoint, completion: ((Bool)->Void)?){
        UIView.animate(withDuration: duration, delay:0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.frame = CGRect(x: position.x, y: position.y, width: self.width, height: self.width)
        }, completion: completion)
    }
    
    func updateColor(value: Int) -> CGColor{
        var backgroundColor: UIColor
        switch value {
        case 2:
            backgroundColor = UIColor(red: 20.0/255, green: 20.0/255, blue: 80.0/255, alpha: 0.6)
            break
        case 4:
            backgroundColor = UIColor(red: 20.0/255, green: 20.0/255, blue: 140.0/255, alpha: 0.6)
            break
        case 8:
            backgroundColor = UIColor(red:20.0/255, green:60.0/255, blue:220.0/255, alpha: 0.6)
            break
        case 16:
            backgroundColor = UIColor(red:20.0/255, green:120.0/255, blue:120.0/255, alpha: 0.6)
            break
        case 32:
            backgroundColor = UIColor(red:20.0/255, green:160.0/255, blue:120.0/255, alpha: 0.6)
            break
        case 64:
            backgroundColor = UIColor(red:20.0/255, green:160.0/255, blue:60.0/255, alpha: 0.6)
            break
        case 128:
            backgroundColor = UIColor(red:50.0/255, green:160.0/255, blue:60.0/255, alpha: 0.6)
            break
        case 256:
            backgroundColor = UIColor(red:80.0/255, green:120.0/255, blue:60.0/255, alpha: 0.6)
            break
        case 512:
            backgroundColor = UIColor(red:140.0/255, green:70.0/255, blue:60.0/255, alpha: 0.6)
            break
        case 1024:
            backgroundColor = UIColor(red:170.0/255, green:30.0/255, blue:60.0/255, alpha: 0.6)
            break
        case 2048:
            backgroundColor = UIColor(red:220.0/255, green:30.0/255, blue:30.0/255, alpha: 0.6)
            break
        default:
            backgroundColor = UIColor.green
            break
        }
        
        return backgroundColor.cgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
