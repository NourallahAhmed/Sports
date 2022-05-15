//
//  HomePresenter.swift
//  Sports
//
//  Created by NourAllah Ahmed on 5/12/22.
//  Copyright © 2022 NourAllah Ahmed. All rights reserved.
//

import Foundation
import UIKit
import Network
class HomePresenter {
    
    weak var homeView: HomeProtocol!
    var networkService: FetchSports!
    let queue = DispatchQueue(label: "InternetConnectionMonitor")
    let monitor = NWPathMonitor()
    
    init(sportsService: FetchSports){
        self.networkService = sportsService
    }
    
    func attachView(view: HomeProtocol){
        self.homeView = view
    }
    
    
    
    func getSports(){
        monitor.pathUpdateHandler = { pathUpdateHandler  in
            if pathUpdateHandler.status == .satisfied {
                self.networkService.getSports { (allSports, error) in
                    
                    print(allSports?.sports?.first?.strSport ?? "empty sport")
                    DispatchQueue.main.async {
                        self.homeView.stopIndicator()
                        self.homeView.renderCollection(sports: allSports?.sports ?? [])
                    }
                }
            }
            else{
                DispatchQueue.main.async {
                    self.homeView.checkNetwork()
                    self.homeView.stopIndicator()

                    
                }
            }
        }
        monitor.start(queue: queue)
    }
}
