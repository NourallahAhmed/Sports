//
//  LeagueDetailsPresenter.swift
//  Sports
//
//  Created by NourAllah Ahmed on 5/13/22.
//  Copyright © 2022 NourAllah Ahmed. All rights reserved.
//

import Foundation
import UIKit

class LeagueDetailsPresenter{
    
    var networkService: FetchLeaguesDetails = NetworkSevice()
    weak var leagueDetailsView : LeagueDetailsProtocol!
    
    init(view : LeagueDetailsProtocol) {
        self.leagueDetailsView = view
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
}
