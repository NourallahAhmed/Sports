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
        
      
        let parameters = ["s" : strSport] as [String : String]
        AF.request(Constants.BASE_URL + Constants.GET_ALL_Leagues,parameters: parameters ).responseJSON(completionHandler: { (response) in
                   switch response.result{
                   case .success(_):
                       guard let data = response.data else {
                           return
                       }
                       
                       do{
                        let result = try JSONDecoder().decode(AllLegaues.self, from: data)
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
        let parameters = ["id" : leagueId] as [String : String]
        AF.request(Constants.BASE_URL + Constants.GET_EVENTS, parameters: parameters ).responseJSON(completionHandler: { (response) in
            
            switch response.result{
                case .success(_):
                    guard let data = response.data else {
                        return
                    }

                    do{
                        let result = try JSONDecoder().decode(AllLatestEvents.self, from: data)
                        complitionHandler(result, nil)
                    }
                    catch let error{
                        print(error.localizedDescription)
                        
                    }
                
                case .failure(_):
                    print("from network up coming error")
            }
        })
    }
    
    
    func getLeaguesLatestEvents(leagueId: String, complitionHandler: @escaping (AllLatestEvents?, Error?) -> Void) {
        
        let parameters = ["id" : leagueId] as [String : String]
        AF.request(Constants.BASE_URL + Constants.GET_EVENTS, parameters: parameters ).responseJSON(completionHandler: { (response) in
            switch response.result{
                case .success(_):
                    guard let data = response.data else {
                        return
                    }
                    do{
                        let result = try JSONDecoder().decode(AllLatestEvents.self, from: data)
                        complitionHandler(result, nil)
                    }
                    catch{}
                case .failure(_):
                    print("from network leatest error")
            }
        })
    }
    
    
    func getLeaguesTeams(strLeague: String, complitionHandler: @escaping (AllTeams?, Error?) -> Void) {
        
        
        let parameters = ["l" : strLeague] as [String : String]
        AF.request(Constants.BASE_URL + Constants.GET_ALL_Teams,parameters: parameters ).responseJSON(completionHandler: { (response) in
            switch response.result{
                case .success(_):
                    guard let data = response.data else {
                           return
                    }
                       
                    do{
                        let result = try JSONDecoder().decode(AllTeams.self, from: data)
                        complitionHandler(result, nil)
                    }
                    catch{}
                case .failure(_):
                    print("error")
            }
        })
    }
}
