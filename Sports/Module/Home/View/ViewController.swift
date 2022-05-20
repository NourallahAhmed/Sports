//
//  ViewController.swift
//  Sports
//
//  Created by NourAllah Ahmed on 5/11/22.
//  Copyright © 2022 NourAllah Ahmed. All rights reserved.
//

import UIKit
import Kingfisher

protocol HomeProtocol: AnyObject {
    func renderCollection(sports: [Sports])
    func stopIndicator()
    func checkNetwork()
}


class ViewController: UIViewController {

    @IBOutlet weak var mySearchBar: UISearchBar!
    @IBOutlet weak var sportsCollection: UICollectionView!
    
    @IBOutlet weak var orientaionBtn: UIBarButtonItem!
    var Sports : [Sports]?
    var AllSports : [Sports]?
    var presenter: HomePresenter!
    let indicator = UIActivityIndicatorView(style: .large)
    var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    var isClicked = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sportsCollection.delegate = self
        self.sportsCollection.dataSource = self
        
        self.mySearchBar.delegate = self
        self.orientaionBtn.image = UIImage(systemName:   "square.split.1x2")

        //MARK: setting 2 items in 1 row with zero space
        
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width/2, height:  UIScreen.main.bounds.height/4)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        sportsCollection!.collectionViewLayout = layout
        
        
        // Do any additional setup after loading the view.
        indicator.center = self.view.center
        self.view.addSubview(indicator)
        indicator.startAnimating()
        
        presenter = HomePresenter(sportsService: NetworkSevice())
        presenter.attachView(view: self)
        
        
        
        presenter.getSports()
        
        
        
        
    }
    
    
    
    @IBAction func changeOrienationBtn(_ sender: UIBarButtonItem) {
        
        if isClicked == false {
            layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
            layout.itemSize = CGSize(width: UIScreen.main.bounds.width/1, height:  UIScreen.main.bounds.height/4)
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            sportsCollection!.collectionViewLayout = layout
          self.orientaionBtn.image = UIImage(systemName: "square.grid.2x2")


            isClicked = true
        }
        else{
            layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
            layout.itemSize = CGSize(width: UIScreen.main.bounds.width/2, height:  UIScreen.main.bounds.height/4)
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            sportsCollection!.collectionViewLayout = layout
            self.orientaionBtn.image = UIImage(systemName:   "square.split.1x2")
            isClicked = false
        }
    }
    
}
extension ViewController : HomeProtocol{
    func renderCollection(sports: [Sports]) {
        self.Sports = sports
        self.AllSports = sports  //for searchbar if it empty
        let imageViewBackground = UIImageView()
        imageViewBackground.image = UIImage(named: "whiteBackGround")
        imageViewBackground.contentMode = UIView.ContentMode.scaleAspectFit
        self.sportsCollection.backgroundView = imageViewBackground
        self.sportsCollection.reloadData()
            
        }
    func stopIndicator() {
        indicator.stopAnimating()
    }
    
    func checkNetwork () {
        
        let imageViewBackground = UIImageView()
        imageViewBackground.image = UIImage(named: "offline")
        imageViewBackground.contentMode = UIView.ContentMode.scaleAspectFit
        self.sportsCollection.backgroundView = imageViewBackground
        self.Sports = []
        self.sportsCollection.reloadData()
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
 
extension ViewController : UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Sports?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sportCell", for: indexPath) as! SportCustomCollectionViewCell
        
        cell.sportImage.image = UIImage(named: "default.png")
        let imageUrl = URL(string: Sports?[indexPath.row].strSportThumb ?? "")
        cell.sportImage.kf.setImage(with: imageUrl,
                                    placeholder: UIImage(named: "default.png") ,
                                    options: nil,
                                    progressBlock: nil)
        
        cell.sportLabel.text = Sports?[indexPath.row].strSport
     
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("index : \(indexPath.row)")
        let leagueScreen = storyboard?.instantiateViewController(identifier: "leagueScreen") as! LeagueTableViewController
        self.navigationController?.pushViewController(leagueScreen, animated: true)
        
        leagueScreen.sportSelected = Sports?[indexPath.row].strSport
        //MARK: - send the sport name to the league presenter through sport presenter
        
        print("sportName: \(Sports?[indexPath.row].strSport)")
    }
}

extension ViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if self.Sports != nil{
            self.Sports = self.Sports?.filter{ $0.strSport!.contains(searchText) }
            self.sportsCollection.reloadData()
            
        }
        if searchText.isEmpty {
            self.Sports = self.AllSports
            self.sportsCollection.reloadData()
        }
    }
  }

