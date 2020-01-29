//
//  Art.swift
//  HonoluluArtMap
//
//  Created by mobapp15 on 29/01/2020.
//  Copyright © 2020 mobapp15. All rights reserved.
//

import Foundation
import MapKit

class Art {
    
    var creator:String
    var date:Int
    var description:String
    var locationname:String
    var imagefile:URL
    var discipline:String
    var title:String
    var coordinates:CLLocationCoordinate2D
    
    init(
        creator:String,
        date:String,
        description:String,
        locationname:String,
        imagefile:String,
        discipline:String,
        title:String,
        latitude:String,
        longitude:String
    ){
        
        let coordinateLat = Double(latitude)
        let coordinateLon = Double(longitude)
        
        self.creator = creator
        self.date = Int.init(date)!
        self.description = description
        self.locationname = locationname
        self.imagefile = URL.init(fileURLWithPath: imagefile)
        self.discipline = discipline
        self.title = title
        self.coordinates = CLLocationCoordinate2D.init(
            latitude: coordinateLat!,
            longitude: coordinateLon!
        )
    }
    
}