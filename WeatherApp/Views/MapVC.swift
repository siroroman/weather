//
//  MapVC.swift
//  WeatherApp
//
//  Created by Roman Siro on 20.06.18.
//  Copyright © 2018 Roman Siro. All rights reserved.
//

import UIKit
import Mapbox

class MapVC: UIViewController, MGLMapViewDelegate {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var viewModel: MapVM?

    private var mapView: MGLMapView!
    private var style: MGLStyle?
    private let mapTypes: [WeatherMapType] = [.precipitation, .clouds, .pressure]

    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {self.setupMapView()}
    }

    func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
        self.style = style
        setupLayers()
        showLayer(of: .precipitation)
        activityIndicator.stopAnimating()
    }

    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
        guard annotation is MGLPointAnnotation else {return nil}
        let reuseIdentifier = "\(annotation.coordinate.longitude)"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)

        if annotationView == nil {
            annotationView = MGLAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            annotationView?.bounds = CGRect(x: 0, y: 0, width: 20, height: 20)
            annotationView?.layer.cornerRadius = (annotationView?.frame.width)! / 2
            annotationView?.layer.borderWidth = 2.0
            annotationView?.layer.borderColor = UIColor.white.cgColor
            annotationView?.backgroundColor = #colorLiteral(red: 0.2549999952, green: 0.7139999866, blue: 0.9840000272, alpha: 1)
        }

        return annotationView
    }

    private func setupMapView() {
        mapView = MGLMapView(frame: view.bounds, styleURL: MGLStyle.satelliteStreetsStyleURL)
        mapView.attributionButton.tintColor = .white
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.delegate = self

        if let center = viewModel?.mapCenterCoordinate {
            mapView.setCenter(center, zoomLevel: 5, direction: 0, animated: false)

            let annotation = MGLPointAnnotation()
            annotation.coordinate = center
            mapView.addAnnotation(annotation)
        }

        view.insertSubview(mapView, at: 0)
    }

    private func setupLayers() {
        for type in mapTypes {
            let url = WeatherWebService().url(for: type)
            let source = MGLRasterTileSource(identifier: type.rawValue, tileURLTemplates: [url], options: [ .tileSize: 256 ])

            let rasterLayer = MGLRasterStyleLayer(identifier: type.rawValue, source: source)
            rasterLayer.isVisible = false

            style?.addSource(source)
            style?.addLayer(rasterLayer)
        }
    }

    private func showLayer(of type: WeatherMapType) {
        let identifiers = mapTypes.map {$0.rawValue}

        _ = style?.layers
            .filter {identifiers.contains($0.identifier)}
            .filter {$0.isVisible == true}
            .map {$0.isVisible = false}

        _ = style?.layers
            .filter {$0.identifier == type.rawValue}
            .first?.isVisible = true
    }

    @IBAction func segmentedControlValueChanged(_ sender: Any) {
        let index = segmentedControl.selectedSegmentIndex
        let type = mapTypes[index]
        showLayer(of: type)
    }


    @IBAction func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }

}
