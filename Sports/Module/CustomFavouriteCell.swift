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
    var url: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func openYoutube(_ sender: Any) {
        if let url = URL(string: "https://" + (url ?? "www.youtube.com")) {
        UIApplication.shared.open(url, completionHandler: { success in
            if success {
                print("opened")
            } else {
                print("failed")
                // showInvalidUrlAlert()
            }
        })
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
