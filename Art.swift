//
//  Art.swift
//  HonoluluArtMap
//
//  Created by mobapp15 on 29/01/2020.
//  Copyright © 2020 mobapp15. All rights reserved.
//

import Foundation
import MapKit

class Art:NSObject {    
    
    var creator:String
    var date:String
    var desc:String
    var locationname:String
    var imagefile:URL
    var discipline:String
    var title:String
    var credit:String
    var latitude:Double
    var longitude:Double
    
    init(
        creator:String,
        date:String,
        description:String,
        locationname:String,
        imagefile:String,
        discipline:String,
        title:String,
        latitude:String,
        longitude:String,
        credit:String
    ){
        self.creator = creator
        self.date = date
        self.desc = description
        self.locationname = locationname
        //self.imagefile = URL(string: imagefile)!
        self.imagefile = URL(string: "https://i.redd.it/kyyk3fbfitd31.png")!
        self.discipline = discipline
        self.title = title
        self.credit = credit
        self.latitude = Double(latitude)!
        self.longitude = Double(longitude)!
    }
    
}
