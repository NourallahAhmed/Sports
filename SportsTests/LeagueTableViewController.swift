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
}

class LeagueTableViewController: UITableViewController {

    var sportSelected :String?
    var leagues: [Legaues]?
    
    var presenter: LeaguePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        
//        cell.budgeIV.layer.masksToBounds = true
//        cell.budgeIV.layer.cornerRadius = cell.budgeIV.bounds.width/4
        
        //cell.budgeIV.clipsToBounds = true
        
    
        
        cell.budgeIV.image = UIImage(named: "default.png")
        let imageUrl = URL(string: leagues?[indexPath.row].strBadge ?? "")
        cell.budgeIV.kf.setImage(with: imageUrl,
                                    placeholder: UIImage(named: "default.png") ,
                                    options: nil,
                                    progressBlock: nil)
        cell.url = leagues?[indexPath.row].strYoutube
        
        return cell
    }
    

//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableViewAutomaticDimension{
//
//        }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension LeagueTableViewController: LeagueProtocol{
    func renderTable(leagues: [Legaues]) {
        self.leagues = leagues
        self.tableView.reloadData()
    }
}
