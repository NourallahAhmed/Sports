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
    weak var leagueDetailsScreen : LeagueDetailsProtocol!
    init(screen : LeagueDetailsProtocol) {
        self.leagueDetailsScreen = screen
    }
    func setTeams(){
        print("setTeams")
        networkService.getLeaguesTeams(strLeague: "English Premier League", complitionHandler:{ (result,error) in
            DispatchQueue.main.async {
                self.leagueDetailsScreen.renderTeamsCollection(teams: (result?.teams)!)
                
            }
        })
    }
}
