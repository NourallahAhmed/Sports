//
//  HomePresenter.swift
//  Sports
//
//  Created by NourAllah Ahmed on 5/12/22.
//  Copyright © 2022 NourAllah Ahmed. All rights reserved.
//

import Foundation
import UIKit

class HomePresenter {
    
    weak var homeView: HomeProtocol!
    var networkService: FetchSports!
    
    init(sportsService: FetchSports){
        self.networkService = sportsService
    }
    
    func attachView(view: HomeProtocol){
        self.homeView = view
    }
    
    
    
    func getSports(){
        networkService.getSports { (allSports, error) in
            
            print(allSports?.sports?.first?.strSport ?? "empty sport")
            DispatchQueue.main.async {
                self.homeView.stopIndicator()
                self.homeView.renderCollection(sports: allSports?.sports ?? [])
            }
        }
    }
}
