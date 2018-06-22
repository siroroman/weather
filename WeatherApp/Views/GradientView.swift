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
        makeGradient()
    }

    private func makeGradient() {
        let topColor = #colorLiteral(red: 0.2430000007, green: 0.5799999833, blue: 0.7960000038, alpha: 1)
        let bottomColor = #colorLiteral(red: 0.3959999979, green: 0.7220000029, blue: 0.90200001, alpha: 1)
        fillWithGradient(startColor: topColor, endColor: bottomColor, startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 0, y: 1))
    }

}
