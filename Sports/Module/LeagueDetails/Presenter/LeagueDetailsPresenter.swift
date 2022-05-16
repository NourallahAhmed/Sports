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
    
    var localAllData : fetchLocalData?
    var deleteData : deleteLocalData?
    var saveNewData : saveToLocalData?
    //1
    var  appdelegate : AppDelegate
    
    //MARK: fetching
    var fetchingDataFromCoreData : [NSManagedObject] = []
    var fetchedData : [Legaues] = []
    var storedLeague : Legaues?
    
    init(view : LeagueDetailsProtocol ,appDelegate : AppDelegate , name : String) {
        self.leagueDetailsView = view
        self.appdelegate = appDelegate
        
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
        saveNewData = ConnectToCoreData(appDelegate: appdelegate)
        saveNewData?.setFavLeague(fav: fav)
    }
    
    func deleteFavLeague( fav : Legaues){
        // MARK: convert leagues to NSManagedObject to delete from entity
        print("delete begining")
        deleteData = ConnectToCoreData(appDelegate: appdelegate)
        deleteData?.deleteLocalData(deleted: fav)
        
        
    }
    
    func fetchFavLeague(){
        localAllData = ConnectToCoreData(appDelegate: appdelegate)
        fetchedData = localAllData?.fetchLocalData() as! [Legaues]
        print(fetchedData)
    }
    
}
