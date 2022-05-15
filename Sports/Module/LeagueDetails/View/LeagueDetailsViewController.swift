//
//  LeagueDetailsViewController.swift
//  Sports
//
//  Created by NourAllah Ahmed on 5/13/22.
//  Copyright © 2022 NourAllah Ahmed. All rights reserved.
//

import UIKit

protocol LeagueDetailsProtocol : AnyObject{
    func renderTeamsCollection(teams : [Teams])
}
class LeagueDetailsViewController: UIViewController  , LeagueDetailsProtocol {
   
    
    @IBOutlet weak var myScrollView: UIScrollView!
    @IBOutlet weak var teamsCollectionView: UICollectionView!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var upComingEventsCollectionView: UICollectionView!
    @IBOutlet weak var favBtn: UIBarButtonItem!
    @IBOutlet weak var leatestEventsCollectionView: UICollectionView!
    
    
    var teams : [Teams]?
    var leaguePresenter : LeagueDetailsPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        upComingEventsCollectionView.delegate = self
        upComingEventsCollectionView.dataSource = self

        teamsCollectionView.delegate = self
        teamsCollectionView.dataSource = self

        leatestEventsCollectionView.dataSource = self
        leatestEventsCollectionView.delegate = self
        
        leaguePresenter = LeagueDetailsPresenter(screen: self)
        leaguePresenter?.setTeams()
    }
    
    
    func renderTeamsCollection(teams: [Teams]) {
        self.teams = teams
        print(teams.count)
        self.upComingEventsCollectionView.reloadData()
        self.leatestEventsCollectionView.reloadData()
        self.teamsCollectionView.reloadData()
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


extension LeagueDetailsViewController : UICollectionViewDataSource,UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var numberOfItems = 0
        print(section)
        if collectionView == leatestEventsCollectionView {
            numberOfItems = teams?.count ?? 0
        }
         if collectionView == upComingEventsCollectionView {
            numberOfItems = teams?.count ?? 0
         }
        else if  collectionView == teamsCollectionView {
            numberOfItems = teams?.count ?? 0
        }

        print("number of items")
        return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("cellfor item ")
        if (collectionView == upComingEventsCollectionView)
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upComingCell", for: indexPath) as! CustomUpComingEventsCell
            cell.matchDate.text = "2020 - 5 - 30"
            cell.matchTime.text = " 12:00 "
            cell.strEvent.text = "upComing Event"
            cell.homeTeamImage.image = UIImage(named: "default.png")
            cell.awayTeamImage.image = UIImage(named: "default.png")

            let imageUrl = URL(string: teams?[indexPath.row].strTeamBadge ?? "")
            cell.homeTeamImage.kf.setImage(with: imageUrl,
                                       placeholder: UIImage(named: "default.png") ,
                                       options: nil,
                                       progressBlock: nil)
            
            cell.awayTeamImage.kf.setImage(with: imageUrl,
                                           placeholder: UIImage(named: "default.png") ,
                                           options: nil,
                                           progressBlock: nil)
            return cell
        }
        else if (collectionView == leatestEventsCollectionView)
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "leatestEventCell", for: indexPath) as! CustomLatestEventsCell
            cell.awayImage.image = UIImage(named: "default.png")
            cell.awayTeam.text = "away Team"
            cell.homeTeam.text = "home Team"
            
            cell.homeImage.image = UIImage(named: "default.png")
            let imageUrl = URL(string: teams?[indexPath.row].strTeamBadge ?? "")
            cell.homeImage.kf.setImage(with: imageUrl,
                                      placeholder: UIImage(named: "default.png") ,
                                      options: nil,
                                      progressBlock: nil)
            
            cell.awayImage.kf.setImage(with: imageUrl,
            placeholder: UIImage(named: "default.png") ,
            options: nil,
            progressBlock: nil)
            
            cell.matchDate.text = " 2020 - 5 - 5 "
            cell.matchResult.text = "3 - 0"
            return cell

        }
        else if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamsCell", for: indexPath)  as? CustomTeamCell {
            cell.teamLogo.image = UIImage(named:"default.png")
            let imageUrl = URL(string: teams?[indexPath.row].strTeamBadge ?? "")
            cell.teamLogo.kf.setImage(with: imageUrl,
                                     placeholder: UIImage(named: "default.png") ,
                                     options: nil,
                                     progressBlock: nil)

            cell.teamLogo.layer.cornerRadius = cell.teamLogo.frame.size.width / 2
            cell.teamLogo.layer.masksToBounds = true
            cell.teamLogo.clipsToBounds = true

            cell.teamLogo.layer.borderColor = UIColor.white.cgColor

            cell.teamLogo.layer.borderWidth = 2
                        
            return cell

        }
        
        return UICollectionViewCell()
    }
    
  
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            var theSize : CGSize?
            if collectionView == leatestEventsCollectionView {
                let padding: CGFloat =  25
                let collectionViewSize = collectionView.frame.size.width - padding
                theSize = CGSize(width: collectionViewSize , height: 115)
            }
            else{
                theSize =  CGSize(width: UIScreen.main.bounds.width , height: UIScreen.main.bounds.height / 3)
            }
            return theSize!
        }
    
}

