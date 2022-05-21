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
    @IBOutlet weak var stadiumDescL: UILabel!
    
    @IBOutlet weak var mynav: UINavigationBar!
    var team: Teams?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if(team == nil){
            print("team: nil")
            
        }
        print("the team : \(String(describing: team))")
        mynav.topItem?.title = team?.strTeam

        teamL.text = team?.strTeam
        let league : String = (team?.strLeague)!
        let year : String = (team?.intFormedYear)!
        let desc : String = (team?.strStadiumDescription)!
        leagueL.text = "League: \(league)"
        formingYearL.text = "Formed Year: \(year)"
        stadiumDescL.text = "Stadium Description: \(desc)"
        
        stadiumIV.image = UIImage(named: "default.png")
        shirtIV.image = UIImage(named: "default.png")
        
        let stadiumUrl = URL(string: team?.strStadiumThumb ?? "default.png")
        let shirtUrl = URL(string: team?.strTeamJersey ?? "default.png")
        
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
        
        if(team?.strWebsite != ""){
        if((team?.strWebsite)!.contains("https://")){
            
            openURL(url: (team?.strWebsite)!)

        }
        else{
            openURL(url: "https://" + (team?.strWebsite)!)}}
        else{
 self.showToast(message: "No Website Available ", font: .systemFont(ofSize: 12.0))        }
    }
    
    @IBAction func openFacebook(_ sender: Any) {
        if(team?.strFacebook != ""){
        if((team?.strFacebook)!.contains("https://")){
                   
                   openURL(url: (team?.strFacebook)!)

               }
               else{
        openURL(url: "https://" + (team?.strFacebook)!)
            }}
        else{
 self.showToast(message: "No Facebook Account", font: .systemFont(ofSize: 12.0))        }
    }
    
    
    @IBAction func openTwitter(_ sender: Any) {
        
        if(team?.strTwitter != ""){
        if(((team?.strTwitter)!.contains("https://")) ){
            
            openURL(url: (team?.strTwitter)!)
            
        }
        else{
            openURL(url: "https://" + (team?.strTwitter)!) }}
        else{
 self.showToast(message: "No Twitter Account", font: .systemFont(ofSize: 12.0))        }
    }
    
    
    @IBAction func openYoutube(_ sender: Any) {
        if(team?.strYoutube != ""){
        
        if((team?.strYoutube)!.contains("https://")) {
            
            openURL(url: (team?.strYoutube)!)
            
        }
        else{
            openURL(url: "https://" + (team?.strYoutube)!)
            
            }}
        else{
            print("no Youtube")
            self.showToast(message: "No YouTube Channel", font: .systemFont(ofSize: 12.0))
        }
    }
    
    @IBAction func backbtn(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true , completion: nil)

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
    
    func showToast(message : String, font: UIFont) {

          let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
          toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
          toastLabel.textColor = UIColor.white
          toastLabel.font = font
          toastLabel.textAlignment = .center;
          toastLabel.text = message
          toastLabel.alpha = 1.0
          toastLabel.layer.cornerRadius = 10;
          toastLabel.clipsToBounds  =  true
          self.view.addSubview(toastLabel)
          UIView.animate(withDuration: 8.0
              , delay: 0.8, options: .curveEaseOut, animations: {
               toastLabel.alpha = 0.0
          }, completion: {(isCompleted) in
              toastLabel.removeFromSuperview()
          })
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
