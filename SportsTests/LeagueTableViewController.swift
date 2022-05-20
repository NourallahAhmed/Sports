//
//  LeagueTableViewController.swift
//  Sports
//
//  Created by abdelrahmanhz on 5/12/22.
//  Copyright © 2022 NourAllah Ahmed. All rights reserved.
//

import UIKit

protocol LeagueProtocol: AnyObject{
    func renderTable(leagues: [Legaues])
    func checkNetwork()
    func showAlert()
}

class LeagueTableViewController: UITableViewController {

    var sportSelected :String?
    var leagues: [Legaues]?
    
    var presenter: LeaguePresenter!
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Leagues"
        presenter  = LeaguePresenter(view: self)
        
        presenter.setSelectedSport(strString: sportSelected!)
        presenter.getAllLeagues()

        self.tableView.rowHeight = UIScreen.main.bounds.height/7
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.leagues?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as! LeagueCustomTableViewCell
        
        cell.nameL.text = leagues?[indexPath.row].strLeague
        
        cell.budgeIV.image = UIImage(named: "default.png")
        let imageUrl = URL(string: leagues?[indexPath.row].strBadge ?? "")
        cell.budgeIV.kf.setImage(with: imageUrl,
                                    placeholder: UIImage(named: "default.png") ,
                                    options: nil,
                                    progressBlock: nil)
        
        
        
        cell.budgeIV.layer.cornerRadius = cell.budgeIV.frame.size.width / 2
        cell.budgeIV.layer.masksToBounds = true
        cell.budgeIV.clipsToBounds = true

        cell.budgeIV.layer.borderColor = UIColor.red.cgColor
        cell.budgeIV.layer.borderWidth = 2
        
        cell.url = leagues?[indexPath.row].strYoutube
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
//        performSegue(withIdentifier: "leagueDetailsScreen", sender: self)
        let leagueDetails = self.storyboard?.instantiateViewController(identifier: "leagueDetailsScreen") as! LeagueDetailsViewController
        leagueDetails.leagueName = leagues?[indexPath.row].strLeague
        leagueDetails.leagueId = leagues?[indexPath.row].idLeague as! String
        leagueDetails.selectedLeague = leagues?[indexPath.row]
        leagueDetails.modalPresentationStyle = .overFullScreen

        self.present(leagueDetails, animated: true, completion: nil)

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }*/

}

extension LeagueTableViewController: LeagueProtocol{
    func renderTable(leagues: [Legaues]) {
        self.leagues = leagues
        self.tableView.reloadData()
    }
    
    
      func checkNetwork () {
        self.tableView.separatorStyle = .none
        self.leagues = []
        self.tableView.reloadData()

        let imageViewBackground = UIImageView()
        imageViewBackground.image = UIImage(named: "offline")
        imageViewBackground.contentMode = UIView.ContentMode.scaleAspectFit
        self.tableView.backgroundView = imageViewBackground
        self.showAlert()
        
    }
      func showAlert(){
          DispatchQueue.main.async {
              let alert : UIAlertController = UIAlertController(title: "ERROR", message: "Please check your internet connection", preferredStyle: .alert)
              alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
              self.present(alert , animated: true , completion: nil)
              
          }
          
      }
}
