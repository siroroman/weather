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

    var viewModel: MapVM?

    var mapView: MGLMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

        mapView = MGLMapView(frame: view.bounds, styleURL: MGLStyle.satelliteStyleURL())
        mapView.attributionButton.tintColor = .white
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.delegate = self

        if let center = viewModel?.mapCenterCoordinate {
            mapView.setCenter(center, zoomLevel: 6, direction: 0, animated: false)
        }

        view.insertSubview(mapView, at: 0)
    }

    func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {

    }

    @IBAction func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }

}
