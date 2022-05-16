//
//  Fav_Presenter.swift
//  Sports
//
//  Created by NourAllah Ahmed on 5/16/22.
//  Copyright © 2022 NourAllah Ahmed. All rights reserved.
//

import Foundation

class FavouritePresenter{
    weak var favScreen : FavouriteScreen?
    var favItems: [Legaues]?
    var localAllData : fetchLocalData?
    var deleteData : deleteLocalData?
    var apd : AppDelegate?
    
    init(favScreen: FavouriteScreen , apd: AppDelegate){
        self.favScreen = favScreen
        self.apd = apd
    }

    
    func getAllData(){
        localAllData = ConnectToCoreData(appDelegate: apd!)
        favItems = localAllData?.fetchLocalData()
        DispatchQueue.main.async {
            self.favScreen?.getAllFav(fav: self.favItems ?? [])
        }
    }
    func deleteItem(item:Legaues?){
        deleteData = ConnectToCoreData(appDelegate: apd!)
        deleteData?.deleteLocalData(deleted: item!)
        DispatchQueue.main.async {
            self.favScreen?.deleteItem()
        }
    }
}
