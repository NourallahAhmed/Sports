//
//  LabelCardView.swift
//  Sports
//
//  Created by NourAllah Ahmed on 5/12/22.
//  Copyright © 2022 NourAllah Ahmed. All rights reserved.
//

import UIKit




@IBDesignable class LabelCardView: UILabel{
    
    @IBInspectable var cornnerRadius : CGFloat = 15
    var offSetWidth : CGFloat = 20
    var ofSetHeight: CGFloat = 20
    var ofSetShadowOpacity : Float = 10
    
    override func layoutSubviews() {
        layer.cornerRadius = self.cornnerRadius
//        layer.shadowOffset = CGSize(width: self.offSetWidth , height : self.ofSetHeight)
//        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: self.cornnerRadius).cgPath
        layer.masksToBounds = true
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}




