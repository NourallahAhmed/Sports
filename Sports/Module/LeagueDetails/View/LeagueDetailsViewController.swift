//
//  LeagueDetailsViewController.swift
//  Sports
//
//  Created by NourAllah Ahmed on 5/13/22.
//  Copyright © 2022 NourAllah Ahmed. All rights reserved.
//

import UIKit

protocol LeagueDetailsProtocol : AnyObject{
    func renderEventsCollections(Events : [Events])
    func renderTeamsCollection(teams : [Teams])
    func changeFavState()
}

class LeagueDetailsViewController: UIViewController {
   
    
    @IBOutlet weak var mynav: UINavigationBar!
    @IBOutlet weak var myScrollView: UIScrollView!
    @IBOutlet weak var teamsCollectionView: UICollectionView!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var upComingEventsCollectionView: UICollectionView!
    @IBOutlet weak var favBtn: UIBarButtonItem!
    @IBOutlet weak var leatestEventsCollectionView: UICollectionView!
    
    
    var upComingEvents : [Events] = []
    var latestEvents : [Events] = []
    var teams : [Teams]?
    
    var leagueName: String?
    var leagueId: String = " "
    var selectedLeague: Legaues?
    var leaguePresenter : LeagueDetailsPresenter?
    
    var isClicked: Bool = false
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        upComingEventsCollectionView.delegate = self
        upComingEventsCollectionView.dataSource = self

        teamsCollectionView.delegate = self
        teamsCollectionView.dataSource = self

        leatestEventsCollectionView.dataSource = self
        leatestEventsCollectionView.delegate = self
    
        mynav.topItem?.title = leagueName
        leaguePresenter = LeagueDetailsPresenter(view: self, appDelegate: appDelegate, name: leagueName ?? " ")
        
        //MARK:- fetch data to set if it in fav
      
        
        leagueId = selectedLeague?.idLeague as! String
        
        
        leaguePresenter?.getAllEvents(leagueId: leagueId)
        leaguePresenter?.getTeams(leagueName: leagueName!)
        
        if ( leaguePresenter?.isSaved(league: selectedLeague!) == true ) {
            self.favBtn.tintColor = UIColor.red
            self.isClicked = true
        }
    }
    
    @IBAction func addToFav(_ sender: Any) {
        //MARK:- saved to coredata
        if(isClicked == false){
            self.favBtn.tintColor = UIColor.red
            self.leaguePresenter?.setFavLeague(fav: selectedLeague!)
            self.leaguePresenter?.fetchFavLeague()
            isClicked = true
        }
        else{
            let alert = UIAlertController(title: "Removing Alert", message: "Remove \"\(selectedLeague?.strLeague ?? "empty")\" from favourite leagues list?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                self.favBtn.tintColor = UIColor.systemBlue
                self.leaguePresenter?.deleteFavLeague(fav: self.selectedLeague!)
                self.isClicked = false
                
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func backToLeagues(_ sender: Any) {
        
        self.dismiss(animated: true , completion: nil)
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

extension LeagueDetailsViewController: LeagueDetailsProtocol{
    func changeFavState() {
        if self.isClicked == false {
            self.favBtn.tintColor = UIColor.red
            self.isClicked = true
        }
        else{
            self.favBtn.tintColor = UIColor.systemBlue
            self.isClicked = false
        }
    }
    
    
    
    //MARK: - get all events and check on the date
    func renderEventsCollections(Events: [Events]) {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
//        print("__________________________________")
//        print(dateFormatter.string(from: date))
//        print(Events.first?.dateEvent!)
    
            for item in Events {
                if(item.dateEvent! > dateFormatter.string(from: date)){
                    print("upComing")
                    self.upComingEvents.append(item)
                }else{
                    
                    print("leatest")
                    self.latestEvents.append(item)
                    
                }
                
                self.upComingEventsCollectionView.reloadData()
                self.leatestEventsCollectionView.reloadData()

            }
        if(upComingEvents.count == 0)  {
            let imageViewBackground = UIImageView()
            imageViewBackground.image = UIImage(named: "noevents")//"noUpComing")
            imageViewBackground.contentMode = UIView.ContentMode.scaleAspectFit
            self.upComingEventsCollectionView.backgroundView = imageViewBackground
            
        }else{
            if(latestEvents.count == 0 ){
                    
                    let imageViewBackground = UIImageView()
                    imageViewBackground.image = UIImage(named: "noevents")
                    imageViewBackground.contentMode = UIView.ContentMode.scaleAspectFit
                    self.leatestEventsCollectionView.backgroundView = imageViewBackground
                    
                    
                }
        }
            
    }
       
    
    func renderTeamsCollection(teams: [Teams]) {
        
        if (teams.count == 0){
            
            let labelBackground = UILabel()
            labelBackground.text = "no Teams available"
            self.teamsCollectionView.backgroundView = labelBackground
            
        }
        else{
            self.teams = teams
            self.teamsCollectionView.reloadData()
        }
        
    }
}


extension LeagueDetailsViewController : UICollectionViewDataSource,UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var numberOfItems = 0
        
        if collectionView == leatestEventsCollectionView {
            numberOfItems = latestEvents.count
        }
        else if collectionView == upComingEventsCollectionView {
            numberOfItems = upComingEvents.count
        }
        else if  collectionView == teamsCollectionView {
            numberOfItems = teams?.count ?? 0
        }

        return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == upComingEventsCollectionView)
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upComingCell", for: indexPath) as! CustomUpComingEventsCell
            cell.matchDate.text = upComingEvents[indexPath.row].dateEvent
            cell.matchTime.text = upComingEvents[indexPath.row].strTime
            cell.strEvent.text = upComingEvents[indexPath.row].strEvent
            cell.upComingImage.image = UIImage(named: "default.png")
            cell.upComingImage.layer.cornerRadius = 5
            
            if(upComingEvents[indexPath.row].strThumb?.contains(".jpg") == true){
                let imageUrl = URL(string: upComingEvents[indexPath.row].strThumb ?? "")

                cell.upComingImage.kf.setImage(with: imageUrl,
                                           placeholder: UIImage(named: "default.png") ,
                                           options: nil,
                                           progressBlock: nil)
            }
            
            
            return cell
        }
        else if (collectionView == leatestEventsCollectionView)
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "leatestEventCell", for: indexPath) as! CustomLatestEventsCell
            cell.awayTeam.text = latestEvents[indexPath.row].strAwayTeam
            cell.homeTeam.text = latestEvents[indexPath.row].strHomeTeam

            cell.latestEvent.image = UIImage(named: "default.png")
            
            if(latestEvents[indexPath.row].strThumb?.contains(".jpg") == true){
                let imageUrl = URL(string: latestEvents[indexPath.row].strThumb ?? "")
                
                cell.latestEvent.kf.setImage(with: imageUrl,
                                          placeholder: UIImage(named: "default.png") ,
                                          options: nil,
                                          progressBlock: nil)
            }

            cell.matchDate.text = latestEvents[indexPath.row].dateEvent

            cell.matchResult.text = String(latestEvents[indexPath.row].intHomeScore  ?? " ") + String("-") + String( latestEvents[indexPath.row].intAwayScore  ?? " " )
            return cell

        }
        else if(collectionView == teamsCollectionView) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamsCell", for: indexPath)  as! CustomTeamCell
            cell.teamLogo.image = UIImage(named:"default.png")
            
            if(teams![indexPath.row].strTeamBadge?.contains(".png") == true){
                let imageUrl = URL(string: teams?[indexPath.row].strTeamBadge ?? "")
                cell.teamLogo.kf.setImage(with: imageUrl,
                                         placeholder: UIImage(named: "default.png") ,
                                         options: nil,
                                         progressBlock: nil)
            }
            

            cell.teamLogo.layer.cornerRadius = cell.teamLogo.frame.size.width / 2
            cell.teamLogo.layer.masksToBounds = true
            cell.teamLogo.clipsToBounds = true

            cell.teamLogo.layer.borderColor = UIColor.purple.cgColor
            cell.teamLogo.layer.borderWidth = 2
            
            cell.backgroundView =  UIImageView(image: UIImage(named:"whiteBackGround"))
            return cell

        }
        
        return UICollectionViewCell()
    }
    
      func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(collectionView == teamsCollectionView) {
          let teamScreen = storyboard?.instantiateViewController(identifier: "teamDetailsScreen") as! TeamDetailsViewController
            teamScreen.team = teams?[indexPath.row]
        
        
        teamScreen.modalPresentationStyle = .overFullScreen

            self.present(teamScreen, animated: true, completion: nil)
        
        
        
//          self.navigationController?.pushViewController(teamScreen, animated: true)
          
//        let destinationVC = TeamDetailsViewController()
//        destinationVC.team = teams?[indexPath.row]
//        self.performSegue(withIdentifier: "showTeamDetails", sender: self)
//          //MARK: - send the sport name to the league presenter through sport presenter
        if(teamScreen != nil){print("test \(teamScreen.team?.strTeam)")}
        print("teamName: \(String(describing: teams?[indexPath.row].strTeam))")
      }
    }
}

