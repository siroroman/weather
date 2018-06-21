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
import RealmSwift

class WeatherDataProvider {
    
    private let refreshTimeIntervalInMinutes: Int = 15
    private let radius: CLLocationDistance = 3000
    
    private let coordinate: CLLocationCoordinate2D
    
    private let database = Database.shared
    
    typealias Completion = (WeatherData?, Error?) -> ()
    
    init(coordinate: CLLocationCoordinate2D ) {
        self.coordinate = coordinate
    }
    
    func data(completion: @escaping Completion) {
        if let data = localData() {
            print("local source")
            return completion(data, nil)
        } else {
            print("remote source")
            remoteData {weather, error  in return completion(weather, error)}
        }
    }
    
    private func localData() -> WeatherData? {
        let databaseData = database
            .fetch(of: WeatherData.self)
            .filter("updated > %@", dateToCompare())
        
        return filterDataByRadius(data: databaseData).first
    }
    
    private func remoteData(completion: @escaping Completion) {
        let webService = WeatherWebService()
        
        webService.loadData(for: coordinate) {data, error in
            guard let data = data else {return completion(nil, error)}
            do {
                let weatherData: WeatherData = try unbox(data: data)
                Database.shared.add(object: weatherData)
                self.deleteOldData()
                return completion(weatherData, nil)
            } catch {
                print("Unable to Unbox Response Due to Error (\(error))")
                return completion(nil, error)
            }
        }
    }
    
    private func deleteOldData() {
        let oldDataToDelete = database
            .fetch(of: WeatherData.self)
            .filter("updated <= %@", dateToCompare())
        oldDataToDelete.forEach {Database.shared.delete(object: $0)}
    }
    
    private func dateToCompare() -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .minute, value: -refreshTimeIntervalInMinutes, to: Date()) ?? Date()
    }
    
    private func filterDataByRadius(data: Results<WeatherData>) -> [WeatherData] {
        var dataInRadius: [WeatherData] = []
        
        let circularRegion = CLCircularRegion(center: coordinate, radius: radius, identifier: "")
        
        data.forEach {
            if circularRegion.contains($0.coordinate) {
                dataInRadius.append($0)
            }
        }
        return dataInRadius
    }
    
}
