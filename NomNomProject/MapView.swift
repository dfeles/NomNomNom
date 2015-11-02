//
//  mapView.swift
//  NomNom
//
//  Created by Daniel Feles on 01/11/2015.
//
//

import UIKit
import MapKit
import CoreLocation


class MapView: UIView, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var map:MKMapView = MKMapView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        map.mapType = .Standard
        map.frame = self.frame
        map.delegate = self
        self.addSubview(map)
        
        self.clipsToBounds = true;
        self.layer.cornerRadius = 5;
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        map.frame = CGRectMake(0, 0, self.frame.width, self.frame.height)
    }
    
    func goTo(address:CLLocation, currentLocation:CLLocation) {
        print(currentLocation)
        print(address)
        
        let coordinateTo:CLLocationCoordinate2D = address.coordinate
        
        
        var middlePoint:CLLocationCoordinate2D = CLLocationCoordinate2D()
        middlePoint.latitude = (address.coordinate.latitude + currentLocation.coordinate.latitude) / 2.0
        middlePoint.longitude = (address.coordinate.longitude + currentLocation.coordinate.longitude) / 2.0

        let meters:CLLocationDistance = currentLocation.distanceFromLocation(address)*1.2
        
        let region = MKCoordinateRegionMakeWithDistance(middlePoint, meters, meters)
        //MKCoordinateRegion(center: middlePoint, span: span)
        self.map.setRegion(region, animated: true)
        
        
        // Drop a pin
        let toPin = MKPointAnnotation()
        toPin.coordinate = coordinateTo
        self.map.addAnnotation(toPin)
        
        
        let fromPin = MKPointAnnotation()
        fromPin.coordinate = currentLocation.coordinate
        fromPin.title = "Current location"
        self.map.addAnnotation(fromPin)
        
        
    }
}

