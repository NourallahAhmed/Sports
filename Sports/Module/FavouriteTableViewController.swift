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
    @IBOutlet weak var clearbarbtn: UIBarButtonItem!
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

        favPresenter?.getAllData()
        print(self.favItems?.isEmpty as Any)
       

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
        cell.url = favItems?[indexPath.row].strYoutube
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
                if self.favItems?.isEmpty ?? true{
                    self.clearbarbtn.isEnabled  = false
                    self.tableView.backgroundView?.addSubview (UIImageView(image: UIImage(named: "empty.png")))

                }
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
                    leagueDetails.leagueId = self.favItems?[indexPath.row].idLeague as! String
                    leagueDetails.selectedLeague = self.favItems?[indexPath.row]
                    leagueDetails.modalPresentationStyle = .overFullScreen
                    
                    self.present(leagueDetails, animated: true, completion: nil)
                }
               
                }
               else{
                print("no internet")
                DispatchQueue.main.async {
                    let alert : UIAlertController = UIAlertController(title: "ERROR", message: "Please check your internet connection", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
                    self.present(alert , animated: true , completion: nil)
                                
                    }
                }
            }
            monitor.start(queue: queue)

        }
 

    @IBAction func clearBtn(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Removing Alert", message: "Remove all leagues from favourite list?", preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                    if (self.favItems!.isEmpty == false){
                        for item in self.favItems! {
                            self.favPresenter?.deleteItem(item: item)
                        }
                        self.favItems?.removeAll()
                        self.tableView.reloadData()
                        self.clearbarbtn.isEnabled = false
                    }
                    
                       print("deleted")
                   }))
                   alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                   self.present(alert, animated: true, completion: nil)
        
        
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
        print("func \(self.favItems?.isEmpty as Any)")
//        self.clearbarbtn.isEnabled  = true
        changeBackground()
        self.tableView.reloadData()
    }
    
    func deleteItem() {
        changeBackground()
        print("okay")
    }
    
    func changeBackground(){
        if (self.favItems?.isEmpty  == true){
            self.clearbarbtn.isEnabled = false
            self.tableView.separatorStyle = .none
            let imageViewBackground = UIImageView()
            imageViewBackground.image = UIImage(named: "empty.png")
            imageViewBackground.contentMode = UIView.ContentMode.scaleAspectFit
            self.tableView.backgroundView = imageViewBackground
        }else{
            self.clearbarbtn.isEnabled  = true
            self.tableView.separatorStyle = .singleLine
            self.tableView.backgroundView = .none
            self.tableView.backgroundView?.addSubview( UIImageView(image: UIImage(named: "whiteBackGround")))
        }
        self.tableView.reloadData()
    }
    
}
