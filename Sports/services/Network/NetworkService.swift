//
//  NetworkService.swift
//  Sports
//
//  Created by abdelrahmanhz on 5/12/22.
//  Copyright © 2022 NourAllah Ahmed. All rights reserved.
//

import Foundation
import Alamofire

protocol FetchSports {
     func getSports(complitionHandler : @escaping (AllSports?, Error?) -> Void)
}

protocol FetchLeagues {
    func getLeagues( strSport : String ,complitionHandler : @escaping (AllLegaues?, Error?) -> Void)

}

protocol FetchLeaguesDetails {
    func getLeaguesTeams( strLeague : String ,complitionHandler : @escaping (AllTeams?, Error?) -> Void)
    func getLeaguesUpComingEvents( leagueId : String ,complitionHandler : @escaping (AllLatestEvents?, Error?) -> Void)
    func getLeaguesLatestEvents( leagueId : String ,complitionHandler : @escaping (AllLatestEvents?, Error?) -> Void)
}

class NetworkSevice: FetchSports{
     func getSports(complitionHandler : @escaping (AllSports?, Error?) -> Void){
      
        AF.request(Constants.BASE_URL + Constants.GET_ALL_SPORTS).responseJSON(completionHandler: { (response) in
            switch response.result{
            case .success(_):
                guard let data = response.data else {
                    return
                }
                
                do{
                    let result = try JSONDecoder().decode(AllSports.self, from: data)
                    print("from network : \(String(describing: result.sports?.first?.strSport))")
                    print("from network : \(String(describing: result.sports?.count))")
                    complitionHandler(result, nil)
                }
                catch{}
            case .failure(_):
                print("error")
            }
        })
    }
}
extension NetworkSevice : FetchLeagues{
    
    func getLeagues(strSport: String, complitionHandler: @escaping (AllLegaues?, Error?) -> Void) {
        
        print("getLeagues from network")
        print(strSport)
        let parameters = ["s" : strSport] as [String : String]
        AF.request(Constants.BASE_URL + Constants.GET_ALL_Leagues,parameters: parameters ).responseJSON(completionHandler: { (response) in
                   switch response.result{
                   case .success(_):
                       guard let data = response.data else {
                           return
                       }
                       
                       do{
                        let result = try JSONDecoder().decode(AllLegaues.self, from: data)
                        print("from Network: \(String(describing: result.countries?.first?.strLeague))")
                        complitionHandler(result, nil)
                       }
                       catch{}
                   case .failure(_):
                       print("error")
                   }
               })
    }
    
    
}
extension NetworkSevice : FetchLeaguesDetails{
    func getLeaguesUpComingEvents(leagueId: String, complitionHandler: @escaping (AllLatestEvents?, Error?) -> Void) {
        
        print("getLeaguesUpComingEvents from network")
        
        let parameters = ["id" : leagueId, "r": "38", "s": "2021-2022"] as [String : String]
        AF.request(Constants.BASE_URL + Constants.GET_EVENTS, parameters: parameters ).responseJSON(completionHandler: { (response) in
            switch response.result{
                case .success(_):
                    guard let data = response.data else {
                        return
                    }
                       
                    do{
                        let result = try JSONDecoder().decode(AllLatestEvents.self, from: data)
                        print("from Network: \(String(describing: result.events?.count))")
                        complitionHandler(result, nil)
                    }
                    catch{}
                case .failure(_):
                    print("error")
            }
        })
    }
    
    
    func getLeaguesLatestEvents(leagueId: String, complitionHandler: @escaping (AllLatestEvents?, Error?) -> Void) {
        
        print("getLeaguesLatestEvents from network")
        
        let parameters = ["id" : leagueId, "r": "35", "s": "2021-2022"] as [String : String]
        AF.request(Constants.BASE_URL + Constants.GET_EVENTS, parameters: parameters ).responseJSON(completionHandler: { (response) in
            switch response.result{
                case .success(_):
                    guard let data = response.data else {
                        return
                    }
                       
                    do{
                        let result = try JSONDecoder().decode(AllLatestEvents.self, from: data)
                        print("from Network: \(String(describing: result.events?.count))")
                        complitionHandler(result, nil)
                    }
                    catch{}
                case .failure(_):
                    print("error")
            }
        })
    }
    
    
    func getLeaguesTeams(strLeague: String, complitionHandler: @escaping (AllTeams?, Error?) -> Void) {
        
        print("getLeaguesTeams from network")
        
        let parameters = ["l" : strLeague] as [String : String]
        AF.request(Constants.BASE_URL + Constants.GET_ALL_Teams,parameters: parameters ).responseJSON(completionHandler: { (response) in
            switch response.result{
                case .success(_):
                    guard let data = response.data else {
                           return
                    }
                       
                    do{
                        let result = try JSONDecoder().decode(AllTeams.self, from: data)
                        print("from Network: \(String(describing: result.teams?.count))")
                        complitionHandler(result, nil)
                    }
                    catch{}
                case .failure(_):
                    print("error")
            }
        })
    }
}
