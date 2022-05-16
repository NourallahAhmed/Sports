//
//  LeagueDetailsPresenter.swift
//  Sports
//
//  Created by NourAllah Ahmed on 5/13/22.
//  Copyright © 2022 NourAllah Ahmed. All rights reserved.
//

import Foundation
import UIKit
import CoreData
class LeagueDetailsPresenter{
    
    var networkService: FetchLeaguesDetails = NetworkSevice()
    weak var leagueDetailsView : LeagueDetailsProtocol!
    
    
    //MARK:- CoreData
    //1
    var viewContext : NSManagedObjectContext = NSManagedObjectContext()
    var entity : NSEntityDescription?
    var  appdelegate : AppDelegate
    
    //MARK: fetching
    var fetchingDataFromCoreData : [NSManagedObject] = []
    var fetchedData : [Legaues] = []
    var storedLeague : Legaues?
    
    init(view : LeagueDetailsProtocol ,appDelegate : AppDelegate , name : String) {
        self.leagueDetailsView = view
        self.appdelegate = appDelegate
        viewContext = appdelegate.persistentContainer.viewContext
        entity = NSEntityDescription.entity(forEntityName: "Mytable", in: viewContext)
        
        self.fetchFavLeague()
        viewContext.deletedObjects
        do{
         try viewContext.save()
        }
        catch{
            fatalError()
        }
//        for item in fetchedData {
//            if item.strLeague == name {
//                DispatchQueue.main.async {
//                    self.leagueDetailsView.changeFavState()
//                }
//            }
//        }
        
            
        

    }
    
    func  getUpComingEvents(leagueId: String) {
        networkService.getLeaguesUpComingEvents(leagueId: leagueId) { (result, error) in
            DispatchQueue.main.async {
                self.leagueDetailsView.renderUpcomingEventsCollection(upComingEvents: (result?.events) ?? [])
            }
        }
    }
    
    func getLatestEvents(leagueId: String) {
        networkService.getLeaguesLatestEvents(leagueId: leagueId) { (result, error) in
            DispatchQueue.main.async {
                self.leagueDetailsView.renderLatestEventsCollection(latestEvents: (result?.events) ?? [])
            }
        }
    }
    
    func getTeams(leagueName: String){
        print("getTeams")
        networkService.getLeaguesTeams(strLeague: leagueName, complitionHandler:{ (result,error) in
            DispatchQueue.main.async {
                self.leagueDetailsView.renderTeamsCollection(teams: (result?.teams) ?? [])
            }
        })
    }
    
    func setFavLeague( fav : Legaues){
        //3
    
        
        print("setFav \(fav.strLeague)")
        
        //saving to CoreData
        
        //4 create NSManagedObject to save into entity
        let leagueToCoreData = NSManagedObject(entity: entity!, insertInto: viewContext)
        
        leagueToCoreData.setValue(fav.idLeague, forKey: "idLeague")
        leagueToCoreData.setValue(fav.strLeague, forKey: "strLeague")
        leagueToCoreData.setValue(fav.strSport, forKey: "strSport")
        leagueToCoreData.setValue(fav.strYoutube, forKey: "strYoutube")
        leagueToCoreData.setValue(fav.strLogo, forKey: "strLogo")
        leagueToCoreData.setValue(fav.strBadge, forKey: "strBadge")

        
        //5 save to coreData
        do{
            try viewContext.save()
            print("saved!")
        }catch let error {
            print("error while saving : \(error.localizedDescription)")
        }
    }
    
    func deleteFavLeague( fav : Legaues){
        // MARK: convert leagues to NSManagedObject to delete from entity
        print("delete begining")
        let leagueToCoreData = NSManagedObject(entity: entity!, insertInto: viewContext)
        
        leagueToCoreData.setValue(fav.idLeague, forKey: "idLeague")
        leagueToCoreData.setValue(fav.strLeague, forKey: "strLeague")
        leagueToCoreData.setValue(fav.strSport, forKey: "strSport")
        leagueToCoreData.setValue(fav.strYoutube, forKey: "strYoutube")
        leagueToCoreData.setValue(fav.strLogo, forKey: "strLogo")
        leagueToCoreData.setValue(fav.strBadge, forKey: "strBadge")
        viewContext.delete(leagueToCoreData)
        do{
            try viewContext.save()
            print("enter")

//            DispatchQueue.main.async {
//                self.leagueDetailsView.changeFavState()
//            }

            self.fetchFavLeague()
        }
        catch{
            fatalError()
        }
        
    }
    
    func fetchFavLeague(){
        let fetch = NSFetchRequest<NSManagedObject>(entityName: "Mytable")
           do {
               print("start fetching")
               fetchingDataFromCoreData = try viewContext.fetch(fetch)
               for item in fetchingDataFromCoreData {
                storedLeague = Legaues(idLeague:  (item.value(forKey: "idLeague") as? String),
                    strSport: item.value(forKey: "strSport") as? String,
                    strLeague: item.value(forKey: "strLeague") as? String,
                    strCountry:  " ",
                    strWebsite:  " ",
                    strFacebook:  " ",
                    strInstagram:  " ",
                    strTwitter:  " ",
                    strYoutube: item.value(forKey: "strYoutube") as? String,
                    strDescriptionEN:  " ",
                    strBanner:  " ",
                    strBadge: item.value(forKey: "strBadge") as? String,
                    strLogo: item.value(forKey: "strLogo") as? String,
                    strPoster:  " ",
                    strNaming: " ",
                    strLocked: " ")
                fetchedData.append(storedLeague!)
                print(storedLeague?.strLeague)
               }
           }catch let error {
               print("error while fetching data : \(error.localizedDescription)")
           }
    }
    
}
