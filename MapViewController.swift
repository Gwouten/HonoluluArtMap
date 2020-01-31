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
        
        // Haal de lijst met artworks op
        artworks = DAO.sharedInstance.getAllArt()
        
        // Maak annotations om op de kaart te kunnen plaatsen
        let annotations = makeAnnotations(art: artworks!)
        
        // plaats pins op de kaart
        mapView.addAnnotations(annotations)
        
        // Kaart startpositie configureren
        var allLatitudes = [CLLocationDegrees]()
        var allLongitudes = [CLLocationDegrees]()
        for art in artworks! {
            allLatitudes.append(art.latitude)
            allLongitudes.append(art.longitude)
        }
        
        // Min & max latitudes & longitudes
        let maxLat = allLatitudes.max()!
        let maxLon = allLongitudes.max()!
        let minLat = allLatitudes.min()!
        let minLon = allLongitudes.min()!
        
        // definieer het getoonde oppervlak van de kaart
        let span = MKCoordinateSpan.init(
            latitudeDelta: maxLat - minLat + 0.1,
            longitudeDelta: maxLon - minLon + 0.1
        )
        
        // definier centraal punt van de kaart
        let center = CLLocationCoordinate2D(
            latitude: minLat + (maxLat - minLat) / 2,
            longitude: minLon + (maxLon - minLon) / 2
        )
        
        // Pas alles toe op de kaart
        mapView.region = MKCoordinateRegion.init(center: center, span: span)
    }
    
    func makeAnnotations(art: [Art]) -> [Annotation]{
        var annotations = [Annotation]()
        for piece in art {
            let newAnnotation = Annotation.init(
                creator: piece.creator,
                date: piece.date,
                description: piece.desc,
                locationname: piece.locationname,
                imagefile: piece.imagefile,
                discipline: piece.discipline,
                title: piece.title!,
                latitude: piece.latitude,
                longitude: piece.longitude,
                credit: piece.credit
            )
            annotations.append(newAnnotation)
        }
        return annotations
    }
    
}

extension MapViewController: MKMapViewDelegate {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let annotation = sender as! MKAnnotationView
        let artAnnotation = annotation.annotation as! Art
        let destination = segue.destination as! DetailViewController
        destination.artWork = artAnnotation
    }
    
    // Doe iets als een marker getriggerd wordt
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        performSegue(withIdentifier: "mapToDetail", sender: view)
    }
 
}
