//
//  UIView+Gradient.swift
//  WeatherApp
//
//  Created by Roman Siro on 19.06.18.
//  Copyright © 2018 Roman Siro. All rights reserved.
//

import UIKit

extension UIView {

    func fillWithGradient(startColor: UIColor , endColor: UIColor, startPoint: CGPoint, endPoint: CGPoint) {

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]

        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint

        layer.addSublayer(gradientLayer)
    }

}
