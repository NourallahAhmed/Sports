//
//  ConnectToCoreData.swift
//  Sports
//
//  Created by NourAllah Ahmed on 5/16/22.
//  Copyright © 2022 NourAllah Ahmed. All rights reserved.
//

import Foundation
import CoreData

protocol fetchLocalData{
    func fetchLocalData()  -> [Legaues]
}
protocol deleteLocalData {
    func deleteLocalData(deleted : Legaues)
}

protocol saveToLocalData {
    func setFavLeague(fav: Legaues)
}

protocol fetchSpecificLeague {
    func fetchSpecificLeague(fav: Legaues) -> Bool
}
class ConnectToCoreData{
    //MARK:- CoreData
    //2
    var viewContext : NSManagedObjectContext = NSManagedObjectContext()
    
    //3
    var entity : NSEntityDescription?

    // MARK: fetching
    var fetchingDataFromCoreData : [NSManagedObject] = []
    var fetchedData : [Legaues] = []
    var storedLeague : Legaues?
    var app :AppDelegate?
    
    init(appDelegate : AppDelegate){
        self.app = appDelegate
        //1 -> AppDelegate
        viewContext = appDelegate.persistentContainer.viewContext
        
        entity = NSEntityDescription.entity(forEntityName: "Mytable", in: viewContext)
    }
}

//MARK:- set savedleague

extension ConnectToCoreData : saveToLocalData {
    func setFavLeague(fav: Legaues) {
        //4 create NSManagedObject to save into entity
        let leagueToCoreData = NSManagedObject(entity: entity!, insertInto: viewContext)
        
        leagueToCoreData.setValue(fav.idLeague, forKey: "idLeague")
        leagueToCoreData.setValue(fav.strLeague, forKey: "strLeague")
        leagueToCoreData.setValue(fav.strSport, forKey: "strSport")
        leagueToCoreData.setValue(fav.strYoutube, forKey: "strYoutube")
        leagueToCoreData.setValue(fav.strLogo, forKey: "strLogo")
        leagueToCoreData.setValue(fav.strBadge, forKey: "strBadge")
        
        
        //5 save to coreData
        do{
            try viewContext.save()
            print("saved!")
        }catch let error {
            print("error while saving : \(error.localizedDescription)")
        }
    }
}

//MARK:- delete saved item

extension ConnectToCoreData:deleteLocalData{
    func deleteLocalData(deleted: Legaues) {
        // MARK: convert leagues to NSManagedObject to delete from entity
        print("delete begining")
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Mytable")
        fetchRequest.predicate = NSPredicate.init(format: "idLeague==\(deleted.idLeague!)")

        do {
            let objects = try viewContext.fetch(fetchRequest)
            for object in objects {
                viewContext.delete(object)
            }
            try viewContext.save()
        }catch{
            print("Couldn't delete movie!")
        }
    }
}
extension ConnectToCoreData : fetchSpecificLeague {
    func fetchSpecificLeague(fav: Legaues) -> Bool {
        var returned : Bool = false
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Mytable")
            fetchRequest.predicate = NSPredicate.init(format: "idLeague==\(fav.idLeague!)")

            do {
                let objects = try viewContext.fetch(fetchRequest)
                print("in coreData \(objects.first?.value(forKey: "strLeague"))")
                if (objects.first != nil){
                    returned = true
                }
                else{
                    returned = false
                }
            }catch{
                print("Couldn't delete movie!")
            }
        return returned    }
    
    
}

//MARK:- Fetch All Data
extension ConnectToCoreData: fetchLocalData {
    func fetchLocalData() -> [Legaues] {
        let fetch = NSFetchRequest<NSManagedObject>(entityName: "Mytable")
        do {
            print("start fetching")
            fetchingDataFromCoreData = try viewContext.fetch(fetch)
            for item in fetchingDataFromCoreData {
                storedLeague = Legaues(idLeague:  (item.value(forKey: "idLeague") as? String),
                                       strSport: item.value(forKey: "strSport") as? String,
                                       strLeague: item.value(forKey: "strLeague") as? String,
                                       strCountry:  " ",
                                       strWebsite:  " ",
                                       strFacebook:  " ",
                                       strInstagram:  " ",
                                       strTwitter:  " ",
                                       strYoutube: item.value(forKey: "strYoutube") as? String,
                                       strDescriptionEN:  " ",
                                       strBanner:  " ",
                                       strBadge: item.value(forKey: "strBadge") as? String,
                                       strLogo: item.value(forKey: "strLogo") as? String,
                                       strPoster:  " ",
                                       strNaming: " ",
                                       strLocked: " ")
                fetchedData.append(storedLeague!)
                print(storedLeague?.strLeague)
            }
        }catch let error {
            print("error while fetching data : \(error.localizedDescription)")
        }
        
        return fetchedData
    }
    
    
}
