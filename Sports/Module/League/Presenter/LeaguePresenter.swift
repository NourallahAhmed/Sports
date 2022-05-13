//
//  LeaguePresenter.swift
//  Sports
//
//  Created by NourAllah Ahmed on 5/13/22.
//  Copyright © 2022 NourAllah Ahmed. All rights reserved.
//

import Foundation



class LeaguePresenter {
    var SelectedSport : String?
    
    var result:[Legaues]!
//    weak var LeagaueView: LeagueProtocol!
    var networkService: FetchLeagues = NetworkSevice()
    
    
  
    func getSelectedSport(strString : String){
        self.SelectedSport = strString
    }
    func getAllLeagues(){
        
        //MARK:- selected sport from HomePresenter
        networkService.getLeagues(strSport: SelectedSport! , complitionHandler: {
            (result,error) in
            print("network")
            print(error)
            DispatchQueue.main.async {
                print("from presenter : \(result?.countries?.first?.strLeague)")
            }
        })
    }

    
}
