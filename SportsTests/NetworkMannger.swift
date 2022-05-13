//
//  NetworkMannger.swift
//  SportsTests
//
//  Created by NourAllah Ahmed on 5/13/22.
//  Copyright © 2022 NourAllah Ahmed. All rights reserved.
//

import Foundation
@testable  import Sports

protocol NetworkManagerProtocol{
    func loadDataFromURL(url: String, complitionHandler: @escaping ([AllLegaues]?,Error?)->Void)
}

class MockNetworkManager{
    var shouldReturnError : Bool
    init (shouldReturnError : Bool){
        self.shouldReturnError = shouldReturnError
    }
    let mockItemsJSONResponse : [[String : Any]] = [
      ["id":"tt9419884",
       "rank":"1",
       "title":"Doctor Strange in the Multiverse of Madness",
       "image":"https://m.media-amazon.com/images/M/MV5BNWM0ZGJlMzMtZmYwMi00NzI3LTgzMzMtNjMzNjliNDRmZmFlXkEyXkFqcGdeQXVyMTM1MTE1NDMx._V1_UX128_CR0,3,128,176_AL_.jpg",
       "weekend":"$187.4M",
       "gross":"$187.4M",
       "weeks":"1"]
    ]
    enum ResponseWithError : Error{
        case responseError
    }
}
extension MockNetworkManager : NetworkManagerProtocol{
    func loadDataFromURL(url: String, complitionHandler: @escaping ([AllLegaues]?, Error?) -> Void) {
        if shouldReturnError{
            complitionHandler(nil,ResponseWithError.responseError)
            
            
        }else{
            var items = [AllLegaues]()
            do{
                let tempitem = try JSONSerialization.data(withJSONObject: mockItemsJSONResponse)
                items = try JSONDecoder().decode([AllLegaues].self , from:tempitem)
            }catch{
                print(error.localizedDescription)
            }
            complitionHandler(items,nil)
        }
}
}
