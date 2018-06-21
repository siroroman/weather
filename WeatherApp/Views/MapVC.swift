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

    var viewModel: MapVM?

    private var mapView: MGLMapView!
    private var style: MGLStyle?
    private let mapTypes: [WeatherMapType] = [.precipitation, .clouds, .pressure]

    override func viewDidLoad() {
        super.viewDidLoad()

        mapView = MGLMapView(frame: view.bounds, styleURL: MGLStyle.satelliteStyleURL())
        mapView.attributionButton.tintColor = .white
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.delegate = self

        if let center = viewModel?.mapCenterCoordinate {
            mapView.setCenter(center, zoomLevel: 4, direction: 0, animated: false)

            let annotation = MGLPointAnnotation()
            annotation.coordinate = center
            mapView.addAnnotation(annotation)
        }

        view.insertSubview(mapView, at: 0)
    }

    func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
        self.style = style
        setupLayers()
        showLayer(of: .temperature)
    }

    @IBAction func segmentedControlValueChanged(_ sender: Any) {
        let index = segmentedControl.selectedSegmentIndex
        let type = mapTypes[index]
        showLayer(of: type)
    }


    @IBAction func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }

    private func setupLayers() {
        for type in mapTypes {
            let url = WeatherWebService().url(for: type)
            let source = MGLRasterSource(identifier: type.rawValue, tileURLTemplates: [url], options: [ .tileSize: 256 ])
            let rasterLayer = MGLRasterStyleLayer(identifier: type.rawValue, source: source)

            rasterLayer.rasterOpacity =  MGLStyleValue(rawValue: 1)
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

}
