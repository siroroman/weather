//
//  WeatherIconProvider.swift
//  WeatherApp
//
//  Created by Roman Siro on 20.06.18.
//  Copyright © 2018 Roman Siro. All rights reserved.
//

import Foundation

class WeatherIconProvider {

    static func icon(for weatherID: Int) -> WeatherIcon? {
        switch weatherID {
        case 200...232: return .storm
        case 300...321: return .shower
        case 500...531: return .rain
        case 600...622: return .snow
        case 700...781: return .fog
        case 800:       return .sun
        case 801:       return .fewClouds
        case 802...804: return .clouds
        default:        return nil
        }
    }

}
