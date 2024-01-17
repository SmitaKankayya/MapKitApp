//
//  ViewController.swift
//  MapKitView
//
//  Created by Smita Kankayya on 11/01/24.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var bitcodePin : MKPlacemark?
    var pointAnnotation : MKPointAnnotation?
    var mkCircle : MKCircle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setPinUsingMKPlacemark()
        //setPointUsingAnnotation()
        drawCircleOnMKMapView()
        drawPolygonOnMKMapView()
        drawPolylineOnMKMapView()
        mapView.delegate = self
    }
    
    func setPinUsingMKPlacemark(){
        let bitcodeCoordinate = CLLocationCoordinate2D(latitude: 18.5091, longitude: 73.8326)
        bitcodePin = MKPlacemark(coordinate: bitcodeCoordinate)
        let region = MKCoordinateRegion(center: bitcodeCoordinate, latitudinalMeters: 800.0, longitudinalMeters: 800.0)
        mapView.setRegion(region, animated: true)
        mapView.addAnnotation(bitcodePin!)
    }
    
    func setPointUsingAnnotation(){
        pointAnnotation = MKPointAnnotation()
        pointAnnotation?.coordinate = CLLocationCoordinate2D(latitude: 18.5195, longitude: 73.8553)
        pointAnnotation?.title = "Shaniwar Wada"
        let shaniwarWadaRegion = MKCoordinateRegion(center: pointAnnotation!.coordinate, latitudinalMeters: 800.0, longitudinalMeters: 800.0  )
        mapView.setRegion(shaniwarWadaRegion, animated: true)
        mapView.addAnnotation(pointAnnotation!)
    }
    
    func drawCircleOnMKMapView(){
        let circleOverlay = MKCircle(center: CLLocationCoordinate2D(latitude: 28.7041, longitude: 77.1025), radius: 200000)
        circleOverlay.title = "Delhi"
        //mapView.mapType = .satellite
        mapView.addOverlay(circleOverlay)
    }
    
    func drawPolygonOnMKMapView(){
        let coordinates: [CLLocationCoordinate2D] = [
            CLLocationCoordinate2D(latitude: 19.9975, longitude: 73.7898),
            CLLocationCoordinate2D(latitude: 19.8762, longitude: 75.3433),
            CLLocationCoordinate2D(latitude: 17.6599, longitude: 75.9064),
            CLLocationCoordinate2D(latitude: 18.5204, longitude: 73.8567)]
        let polygonOverlay = MKPolygon(coordinates: coordinates, count: coordinates.count)
        //mapView.mapType = .satellite
        mapView.addOverlay(polygonOverlay)
    }
    
    func drawPolylineOnMKMapView(){
        let polylineCoordinates: [CLLocationCoordinate2D] = [
            CLLocationCoordinate2D(latitude: 20.3839, longitude: 78.1307),
            CLLocationCoordinate2D(latitude: 21.1458, longitude: 79.0882),
            CLLocationCoordinate2D(latitude: 19.9615, longitude: 79.2961),
            CLLocationCoordinate2D(latitude: 19.6766, longitude: 78.5321),
            CLLocationCoordinate2D(latitude: 20.3839, longitude: 78.1307)
        ]
        let polylineOverlay = MKPolyline(coordinates: polylineCoordinates, count: polylineCoordinates.count)
        //mapView.mapType = .satellite
        mapView.addOverlay(polylineOverlay)
    }
}
extension ViewController : MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let circleOverlay = overlay as? MKCircle {
            let circleRenderer = MKCircleRenderer(overlay: circleOverlay)
            circleRenderer.circle.title = "Hyderabad"
            circleRenderer.strokeColor = UIColor.orange
            circleRenderer.fillColor = UIColor.blue.withAlphaComponent(0.2)
            circleRenderer.lineWidth = 2
            return circleRenderer
        } else if let polygonOverlay = overlay as? MKPolygon {
            let polygonRenderer = MKPolygonRenderer(overlay: polygonOverlay)
            polygonRenderer.strokeColor = UIColor.red
            polygonRenderer.fillColor = UIColor.red.withAlphaComponent(0.2)
            polygonRenderer.lineWidth = 2
            return polygonRenderer
        } else if let polylineOverlay = overlay as? MKPolyline {
            let polylineRenderer = MKPolylineRenderer(overlay: polylineOverlay)
            polylineRenderer.strokeColor = UIColor.blue
            polylineRenderer.lineWidth = 2
            return polylineRenderer
        }
        
        return MKOverlayRenderer()
    }
}

