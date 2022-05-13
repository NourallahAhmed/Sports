//
//  ViewController.swift
//  Sports
//
//  Created by NourAllah Ahmed on 5/11/22.
//  Copyright © 2022 NourAllah Ahmed. All rights reserved.
//

import UIKit
import Kingfisher
protocol HomeProtocol {
    func renderCollection()
    func stopIndicator()
}
class ViewController: UIViewController {

    @IBOutlet weak var sportsCollection: UICollectionView!
    
    var Sports : [Sports]?
    let networkSevice: FetchSports = NetworkSevice()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sportsCollection.delegate = self
        self.sportsCollection.dataSource = self
        
        //MARK: setting 2 items in 1 row with zero space
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width/2, height:  UIScreen.main.bounds.height/4)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        sportsCollection!.collectionViewLayout = layout
        
        
        // Do any additional setup after loading the view.
        networkSevice.getSports { (items, error) in
            DispatchQueue.main.async {
                self.Sports = items?.sports
                self.sportsCollection.reloadData()
                print(items?.sports?.first?.strSport)
            }
        }
    }
}
extension ViewController : HomeProtocol{
    func renderCollection() {
        print("okay")
    }
    
    func stopIndicator() {
        print("okay")

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
    
    
}
