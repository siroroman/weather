//
//  CurrentWeatherWebService.swift
//  WeatherApp
//
//  Created by Roman Siro on 19.06.18.
//  Copyright © 2018 Roman Siro. All rights reserved.
//

import CoreLocation
import Foundation
import Alamofire

class WeatherWebService {

    private let appID = "33529d0203a6eba27e18e70e501a02c3"

    func loadData(for coordinate: CLLocationCoordinate2D, completion: @escaping (_ data: Data?, _ error: Error?) -> ()) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        Alamofire
            .request(url(coordinate: coordinate))
            .responseData {response in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                completion(response.data, response.error)
        }
    }

    func url(for layer: WeatherMapType) -> String {
        let baseURL = "https://tile.openweathermap.org"
        return "\(baseURL)/map/\(layer.rawValue)/{z}/{x}/{y}.png?appid=\(appID)"
    }

    private func url(coordinate: CLLocationCoordinate2D) -> String {
        let baseURL = "https://api.openweathermap.org"
        return "\(baseURL)/data/2.5/weather?lat=\(coordinate.latitude)&lon=\(coordinate.longitude)&APPID=\(appID)&units=metric"
    }
    
}
