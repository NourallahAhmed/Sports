//
//  LeaguePresenter.swift
//  Sports
//
//  Created by NourAllah Ahmed on 5/13/22.
//  Copyright © 2022 NourAllah Ahmed. All rights reserved.
//

import Foundation
import UIKit
import Network

class LeaguePresenter {
    
    var SelectedSport : String?
    
    weak var leagaueView: LeagueProtocol!
    var networkService: FetchLeagues = NetworkSevice()
      let queue = DispatchQueue(label: "InternetConnectionMonitor")
      let monitor = NWPathMonitor()
    init(view: LeagueProtocol) {
        self.leagaueView = view
    }
  
    func setSelectedSport(strString : String){
        self.SelectedSport = strString
    }
    func getAllLeagues(){
        
        //MARK:- selected sport from HomePresenter
        monitor.pathUpdateHandler = { pathUpdateHandler  in
            if pathUpdateHandler.status == .satisfied {
                self.networkService.getLeagues(strSport: self.SelectedSport! , complitionHandler: {
                    (result,error) in
                    DispatchQueue.main.async {
                        self.leagaueView.renderTable(leagues: result?.countries ?? [])
                    }
                })
            }
            else{
                DispatchQueue.main.async {
                    self.leagaueView.checkNetwork()
                }
            }
        }
        monitor.start(queue: queue)
    }
    
}
