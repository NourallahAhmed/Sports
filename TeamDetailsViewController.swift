//
//  TeamDetailsViewController.swift
//  Sports
//
//  Created by Abdelrahman on 5/16/22.
//  Copyright © 2022 NourAllah Ahmed. All rights reserved.
//

import UIKit

class TeamDetailsViewController: UIViewController {

    @IBOutlet weak var stadiumIV: UIImageView!
    @IBOutlet weak var teamL: UILabel!
    @IBOutlet weak var leagueL: UILabel!
    @IBOutlet weak var formingYearL: UILabel!
    @IBOutlet weak var shirtIV: UIImageView!
    
    var team: Teams?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if(team == nil){print("team: nil")}
        teamL.text = team?.strTeam
        leagueL.text = "League: \(String(describing: team?.strLeague))"
        formingYearL.text = "Formed Year: \(String(describing: team?.intFormedYear))"
        
        stadiumIV.image = UIImage(named: "default.png")
        shirtIV.image = UIImage(named: "default.png")
        
        let stadiumUrl = URL(string: team?.strStadiumThumb ?? "default.png")
        let shirtUrl = URL(string: team?.strTeamShort ?? "default.png")
        
        stadiumIV.kf.setImage(with: stadiumUrl,
                                    placeholder: UIImage(named: "default.png") ,
                                    options: nil,
                                    progressBlock: nil)
        shirtIV.kf.setImage(with: shirtUrl,
        placeholder: UIImage(named: "default.png") ,
        options: nil,
        progressBlock: nil)
    }
    
    @IBAction func openWebsite(_ sender: Any) {
        openURL(url: (team?.strWebsite)!)
    }
    
    @IBAction func openFacebook(_ sender: Any) {
        openURL(url: (team?.strFacebook)!)
    }
    
    
    @IBAction func openTwitter(_ sender: Any) {
        openURL(url: (team?.strTwitter)!)
    }
    
    
    @IBAction func openYoutube(_ sender: Any) {
        openURL(url: "https://" + (team?.strYoutube)!)
    }
    
    func openURL(url: String) {
        if let url = URL(string: url) {
        UIApplication.shared.open(url, completionHandler: { success in
            if success {
                print("opened")
            }
            else {
                print("failed")
                // showInvalidUrlAlert()
            }
            })
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
