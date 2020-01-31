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
    let settings = UserDefaults.standard
    
    
    private init(){}
    
    // Persistent Data
    // container voor de op te slagen data
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
    
    // MARK: CRUD
    // MARK: WRITE DATA
    func saveData(art:[Art]){
        print("saveData method called")
        // loopen over Art array om 1 per 1 alles weg te schrijven naar core data
        for piece in art {
            let newArt = Artwork.init(context:persistentContainer.viewContext)
            newArt.creator = piece.creator
            newArt.credit = piece.credit
            newArt.date = piece.date
            newArt.desc = piece.desc
            newArt.discipline = piece.discipline
            newArt.imagefile = piece.imagefile
            newArt.locationname = piece.locationname
            newArt.title = piece.title
            newArt.latitude = piece.latitude
            newArt.longitude = piece.longitude
            saveContext()
        }
        
        // boolean en timestamp opslaan in user default om te zeggen dat de data al gedownload is
        settings.set(true, forKey: "is_downloaded")
    }
    
    // MARK: READ DATA
    func readData() -> [Art]{
        print("readData method called")
        let request = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Artwork")
        do {
            let artworks = try persistentContainer.viewContext.fetch(request) as! [Artwork]
            var art = [Art]()
            for piece in artworks {
                let newArt = Art.init(
                    creator: piece.creator!,
                    date: piece.date!,
                    description: piece.desc!,
                    locationname: piece.locationname!,
                    imagefile: piece.imagefile!.description,
                    discipline: piece.discipline!,
                    title: piece.title!,
                    latitude: piece.latitude.description,
                    longitude: piece.longitude.description,
                    credit: piece.credit!
                )
                art.append(newArt)
            }
            return art
        } catch {
            return []
        }
    }
    
    // MARK: JSON
    func getAllArt() -> [Art]{
        var allArt = [Art]()

        if settings.bool(forKey: "is_downloaded") {
            allArt = readData()
        } else {
        
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
            saveData(art: allArt)
        }
        return allArt
    }
    
}
