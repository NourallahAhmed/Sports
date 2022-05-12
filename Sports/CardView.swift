//
//  CardView.swift
//  Sports
//
//  Created by NourAllah Ahmed on 5/12/22.
//  Copyright © 2022 NourAllah Ahmed. All rights reserved.
//

import UIKit


@IBDesignable class CardView: UIView {
    
    @IBInspectable var cornnerRadius : CGFloat = 5
    var offSetWidth : CGFloat = 5
    var ofSetHeight: CGFloat = 5
    var ofSetShadowOpacity : Float = 5
    @IBInspectable var colour = UIColor.systemGray4
    
    override func layoutSubviews() {
        layer.cornerRadius = self.cornnerRadius
        layer.shadowColor = self.colour.cgColor
        layer.shadowOffset = CGSize(width: self.offSetWidth , height : self.ofSetHeight)
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: self.cornnerRadius).cgPath
        layer.shadowOpacity = self.ofSetShadowOpacity
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}

