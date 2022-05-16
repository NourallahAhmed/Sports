//
//  CustomFavouriteCell.swift
//  Sports
//
//  Created by NourAllah Ahmed on 5/16/22.
//  Copyright © 2022 NourAllah Ahmed. All rights reserved.
//

import UIKit

class CustomFavouriteCell: UITableViewCell {

    @IBOutlet weak var leagueImage: UIImageView!
    @IBOutlet weak var strLeague: UILabel!
    @IBOutlet weak var strYouTube: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
