//
//  LeaguePresenter.swift
//  Sports
//
//  Created by NourAllah Ahmed on 5/13/22.
//  Copyright © 2022 NourAllah Ahmed. All rights reserved.
//

import Foundation
import UIKit


class LeaguePresenter {
    
    var SelectedSport : String?
    
    weak var leagaueView: LeagueProtocol!
    var networkService: FetchLeagues = NetworkSevice()
    
    init(view: LeagueProtocol) {
        self.leagaueView = view
    }
  
    func setSelectedSport(strString : String){
        self.SelectedSport = strString
    }
    func getAllLeagues(){
        
        //MARK:- selected sport from HomePresenter
        networkService.getLeagues(strSport: SelectedSport! , complitionHandler: {
            (result,error) in
            DispatchQueue.main.async {
                self.leagaueView.renderTable(leagues: result?.countries ?? [])
            }
        })
    }

    
}
