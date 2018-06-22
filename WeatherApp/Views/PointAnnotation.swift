//
//  PointAnnotation.swift
//  WeatherApp
//
//  Created by Roman Siro on 22.06.18.
//  Copyright © 2018 Roman Siro. All rights reserved.
//

import UIKit
import Mapbox

class PointAnnotaionVie: MGLAnnotationView {

    override func layoutSubviews() {
        super.layoutSubviews()

        bounds = CGRect(x: 0, y: 0, width: 16, height: 16)
        layer.cornerRadius = bounds.width / 2
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.white.cgColor
        backgroundColor = #colorLiteral(red: 0.2549999952, green: 0.7139999866, blue: 0.9840000272, alpha: 1)
    }

}
