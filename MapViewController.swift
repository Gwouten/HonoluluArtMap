//
//  MapViewController.swift
//  HonoluluArtMap
//
//  Created by mobapp15 on 29/01/2020.
//  Copyright © 2020 mobapp15. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    var artworks:[Art]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Laad alle art
        artworks = DAO.sharedInstance.getAllArt()
        // plaats pins op de kaart
        mapView.addAnnotations(artworks!)
        
        // Kaart startpositie configureren
        var allLatitudes = [CLLocationDegrees]()
        var allLongitudes = [CLLocationDegrees]()
        for art in artworks! {
            allLatitudes.append(art.coordinate.latitude)
            allLongitudes.append(art.coordinate.longitude)
        }
        
        // Min & max latitudes & longitudes
        let maxLat = allLatitudes.max()!
        let maxLon = allLongitudes.max()!
        let minLat = allLatitudes.min()!
        let minLon = allLongitudes.min()!
        
        // definieer oppervlak van de kaart
        let span = MKCoordinateSpan.init(
            latitudeDelta: maxLat - minLat + 0.125,
            longitudeDelta: maxLon - minLon + 0.125
        )
        
        // definier centraal punt van de kaart
        let center = CLLocationCoordinate2D(
            latitude: minLat + (maxLat - minLat) / 2,
            longitude: minLon + (maxLon - minLon) / 2
        )
        
        print(maxLat)
        print(minLat)
        print(maxLon)
        print(minLon)
        
        // Pas alles toe op de kaart
        mapView.region = MKCoordinateRegion.init(center: center, span: span)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MapViewController: MKMapViewDelegate {
    
    
    
}
