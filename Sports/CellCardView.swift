//
//  CellCardView.swift
//  Sports
//
//  Created by abdelrahmanhz on 5/13/22.
//  Copyright © 2022 NourAllah Ahmed. All rights reserved.
//

import UIKit

@IBDesignable class CellCardView: UIView {

    @IBInspectable var cornnerRadius : CGFloat = 15
        
        override func layoutSubviews() {
            layer.cornerRadius = self.cornnerRadius
            layer.masksToBounds = true
    }

}
