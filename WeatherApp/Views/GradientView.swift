//
//  GradientView.swift
//  WeatherApp
//
//  Created by Roman Siro on 19.06.18.
//  Copyright © 2018 Roman Siro. All rights reserved.
//

import UIKit

class GradientView: UIView {

    override func layoutSubviews() {
        super.layoutSubviews()
        applyGradient()
    }

    private func applyGradient() {
        let topColor = UIColor.hexStringToUIColor(hex: "3f93c9")
        let bottomColor = UIColor.hexStringToUIColor(hex: "73bae1")
        fillWithGradient(startColor: topColor, endColor: bottomColor, startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 0, y: 1))
    }
    
}
