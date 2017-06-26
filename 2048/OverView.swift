//
//  OverView.swift
//  2048
//
//  Created by yky on 24/06/2017.
//  Copyright © 2017 yky. All rights reserved.
//

import UIKit

class OverView : UIView {
    
    var btn : UIButton
    
    init(width w: CGFloat, height h : CGFloat) {
        let btnWidth = w / 2
        let x : CGFloat = ( w - btnWidth ) / 2
        let y : CGFloat = (h - btnWidth) / 2
        btn = UIButton(frame: CGRect(x: x, y: y, width: btnWidth, height: btnWidth))
        super.init(frame: CGRect(x: 0, y: 0, width: w, height: h))
        backgroundColor = UIColor(red: 0.28, green: 0.62, blue: 0.24, alpha: 0.8)
        btn.layer.cornerRadius = btnWidth / 2
        btn.setTitle("Restart", for: .normal)
        //[UIColor colorWithRed:0.30 green:0.28 blue:0.28 alpha:1.00]
        btn.backgroundColor = UIColor(red: 0.3, green: 0.28, blue: 0.28, alpha: 0.9)
        addSubview(btn)
        //[UIColor colorWithRed:0.28 green:0.62 blue:0.24 alpha:1.00]

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
