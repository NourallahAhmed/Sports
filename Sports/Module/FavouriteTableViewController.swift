//
//  FavouriteTableViewController.swift
//  Sports
//
//  Created by NourAllah Ahmed on 5/16/22.
//  Copyright © 2022 NourAllah Ahmed. All rights reserved.
//

import UIKit
protocol FavouriteScreen : AnyObject{
    func getAllFav(fav: [Legaues])
    func deleteItem()
}
class FavouriteTableViewController: UITableViewController  {
    var favItems : [Legaues]?
    var favempty : [Legaues] = []

    var favPresenter : FavouritePresenter?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

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
        let imageUrl = URL(string: favItems?[indexPath.row].strLogo ?? "")
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
            favPresenter?.deleteItem(item: favItems?[indexPath.row])
            favItems?.remove(at:indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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
