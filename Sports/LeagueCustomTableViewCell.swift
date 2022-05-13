//
//  LeagueCustomTableViewCell.swift
//  Sports
//
//  Created by abdelrahmanhz on 5/13/22.
//  Copyright © 2022 NourAllah Ahmed. All rights reserved.
//

import UIKit

class LeagueCustomTableViewCell: UITableViewCell {

    @IBOutlet weak var budgeIV: UIImageView!
    @IBOutlet weak var nameL: UILabel!
    var url: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func openYoutube(_ sender: Any) {
        print("clicked!")
        print(url)
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
}
