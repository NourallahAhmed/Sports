//
//  FavouriteTableViewController.swift
//  Sports
//
//  Created by NourAllah Ahmed on 5/16/22.
//  Copyright © 2022 NourAllah Ahmed. All rights reserved.
//

import UIKit
import Network

protocol FavouriteScreen : AnyObject{
    func getAllFav(fav: [Legaues])
    func deleteItem()
}
class FavouriteTableViewController: UITableViewController  {
    var favItems : [Legaues]?
    var favempty : [Legaues] = []

    var favPresenter : FavouritePresenter?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    let queue = DispatchQueue(label: "InternetConnectionMonitor")
    let monitor = NWPathMonitor()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        favPresenter = FavouritePresenter(favScreen: self ,apd: appDelegate)
        favPresenter?.getAllData()
        
    }

    override func viewDidAppear(_ animated: Bool) {
//                favPresenter = FavouritePresenter(favScreen: self ,apd: appDelegate)
        favPresenter?.getAllData()
    }
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
       
        return favItems?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath) as! CustomFavouriteCell
        let imageUrl = URL(string: favItems?[indexPath.row].strBadge ?? "")
        cell.leagueImage.kf.setImage(with: imageUrl,
                                    placeholder: UIImage(named: "default.png") ,
                                    options: nil,
                                    progressBlock: nil)
        cell.strLeague.text = favItems?[indexPath.row].strLeague

        // Configure the cell...

        return cell
    }
    

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let alert = UIAlertController(title: "Removing Alert", message: "Remove \"\(favItems?[indexPath.row].strLeague ?? "empty")\" from favourite leagues list?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                self.favPresenter?.deleteItem(item: self.favItems?[indexPath.row])
                self.favItems?.remove(at:indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .fade)
                print("deleted")
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }


        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
            monitor.pathUpdateHandler = { pathUpdateHandler  in
               if pathUpdateHandler.status == .satisfied {
                DispatchQueue.main.async {
                    let leagueDetails = self.storyboard?.instantiateViewController(identifier: "leagueDetailsScreen") as! LeagueDetailsViewController
                    leagueDetails.leagueName = self.favItems?[indexPath.row].strLeague
                    leagueDetails.leagueId = self.favItems?[indexPath.row].idLeague
                    leagueDetails.selectedLeague = self.favItems?[indexPath.row]
                    leagueDetails.modalPresentationStyle = .overFullScreen
                    
                    self.present(leagueDetails, animated: true, completion: nil)
                }
               
                }
               else{
                DispatchQueue.main.async {
                    let alert : UIAlertController = UIAlertController(title: "ERROR", message: "Please check your internet connection", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
                    self.present(alert , animated: true , completion: nil)
                                
                    }
                }
            }
            monitor.start(queue: queue)

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

extension FavouriteTableViewController : FavouriteScreen {
    func getAllFav(fav: [Legaues])  {
        self.favItems = fav
        
        self.tableView.reloadData()
    }
    
    func deleteItem() {
//        favPresenter?.getAllData()
        print("okay")
    }
//    if(num == 0){
//                       self.tableView.backgroundView = UIImageView(image: UIImage(named: "nofav"))
//                }
//                else{
//                    self.tableView.backgroundView = UIImageView(image: UIImage(named: "whiteBackGround"))
//                }
    
}
