//
//  WeatherDataProvider.swift
//  WeatherApp
//
//  Created by Roman Siro on 19.06.18.
//  Copyright © 2018 Roman Siro. All rights reserved.
//

import Foundation
import CoreLocation
import Unbox

class WeatherDataProvider {

    private let coordinate: CLLocationCoordinate2D

    private let database = Database.shared

    typealias Completion = (WeatherData?, Error?) -> ()

    init(coordinate: CLLocationCoordinate2D ) {
        self.coordinate = coordinate
    }

    func data(completion: @escaping Completion) {
        remoteData {weather, error  in return completion(weather, error)}
    }

    private func localData(completion: @escaping Completion) {
        let results = database.fetch(of: WeatherData.self)
        completion(results.first, nil)
    }

    private func remoteData(completion: @escaping Completion) {
        let webService = WeatherWebService()

        webService.loadData(for: coordinate) {data, error in
            guard let data = data else {return completion(nil, error)}

            do {
                let weatherData: WeatherData = try unbox(data: data)
                return completion(weatherData, nil)
            } catch {
                print("Unable to Unbox Response Due to Error (\(error))")
                return completion(nil, error)
            }
        }
    }

}
