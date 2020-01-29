//
//  DAO.swift
//  HonoluluArtMap
//
//  Created by mobapp15 on 29/01/2020.
//  Copyright © 2020 mobapp15. All rights reserved.
//

import Foundation

class DAO {
    
    static var sharedInstance = DAO.init()
    
    private init(){}
    
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
        return allArt
    }
    
}
