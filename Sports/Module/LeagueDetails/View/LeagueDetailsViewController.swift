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
            numberOfItems = 3
        }
         if collectionView == upComingEventsCollectionView {
            numberOfItems = 3
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
            print("in")
            cell.homeTeamLabel.text = "test"
            return cell
        }
        else if (collectionView == leatestEventsCollectionView)
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "leatestEventCell", for: indexPath) as! CustomLatestEventsCell
            
            cell.resultMatch.text = " test"
            return cell

        }
        else if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamsCell", for: indexPath)  as? CustomTeamCell {
            cell.teamLogo.image = UIImage(named:"default.png")
            let imageUrl = URL(string: teams?[indexPath.row].strTeamBadge ?? "")
            cell.teamLogo.kf.setImage(with: imageUrl,
                                     placeholder: UIImage(named: "default.png") ,
                                     options: nil,
                                     progressBlock: nil)
            cell.teamName.text = teams?[indexPath.row].strTeam
            return cell

        }
        
        return UICollectionViewCell()
    }
    
  
//        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//            var theSize : CGSize?
//            if collectionView == leatestEventsCollectionView {
//                let padding: CGFloat =  25
//                let collectionViewSize = collectionView.frame.size.width - padding
//                theSize = CGSize(width: collectionViewSize , height: 115)
//            }
//            else{
//                theSize =  CGSize(width: UIScreen.main.bounds.width , height: UIScreen.main.bounds.height / 3)
//            }
//            return theSize!
//        }
    
}

