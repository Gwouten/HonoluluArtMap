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
                // Add new artwork to array
                allArt.append(
                    Art.init(
                        creator:      item.value(forKey: "creator")      as! String,
                        date:         item.value(forKey: "date")         as! String,
                        description:  item.value(forKey: "description")  as! String,
                        locationname: item.value(forKey: "location")     as! String,
                        imagefile:    item.value(forKey: "imagefile")    as! String,
                        discipline:   item.value(forKey: "discipline")   as! String,
                        title:        item.value(forKey: "title")        as! String,
                        latitude:     item.value(forKey: "latitude")     as! String,
                        longitude:    item.value(forKey: "longitude")    as! String
                    )
                )
            }
            
        } catch {
            print(error.localizedDescription)
        }
        return allArt
    }
    
}
