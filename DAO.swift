//
//  DAO.swift
//  HonoluluArtMap
//
//  Created by mobapp15 on 29/01/2020.
//  Copyright © 2020 mobapp15. All rights reserved.
//

import Foundation
import CoreData

class DAO {
    
    static var sharedInstance = DAO.init()
    
    private init(){}
    
    // Persistent Data
    // container voor de op te slane data
    lazy var persistentContainer:NSPersistentContainer = {
        let container = NSPersistentContainer.init(name: "Model")
        container.loadPersistentStores(completionHandler: {
            (storeDescription, error) in
        })
        return container
    }()
    
    //functie om data op te slaan
    private func saveContext(){
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    // JSON Fetch
    func getAllArt() -> [Art]{
        
        var allArt = [Art]()
        let url = URL.init(string: "https://data.honolulu.gov/resource/yef5-h88r.json")
        do {
            let rawData = try Data.init(contentsOf: url!)
            let jsonData = try JSONSerialization.jsonObject(with: rawData) as! [NSObject]
            for item in jsonData {
                // Not all data is present, so check first!
                
                var dataCreator = item.value(forKey: "creator")
                if dataCreator == nil {
                    dataCreator = "Onbekend"
                }
                
                var dataDate = item.value(forKey: "date")
                if dataDate == nil {
                    dataDate = "Onbekend"
                }
                
                var dataTitle = item.value(forKey: "title")
                if dataTitle == nil {
                     dataTitle = "No Title"
                }
                
                var dataCredit = item.value(forKey: "credit")
                if dataCredit == nil {
                     dataCredit = "No info"
                }
                
                // Add new artwork to array
                allArt.append(
                    Art.init(
                        creator:      dataCreator                        as! String,
                        date:         dataDate                           as! String,
                        description:  item.value(forKey: "description")  as! String,
                        locationname: item.value(forKey: "location")     as! String,
                        imagefile:    item.value(forKey: "imagefile")    as! String,
                        discipline:   item.value(forKey: "discipline")   as! String,
                        title:        dataTitle                          as! String,
                        latitude:     item.value(forKey: "latitude")     as! String,
                        longitude:    item.value(forKey: "longitude")    as! String,
                        credit:       dataCredit                         as! String
                    )
                )
            }
            
        } catch {
            print(error.localizedDescription)
        }
        DAO.sharedInstance.saveContext()
        return allArt
    }
    
}
