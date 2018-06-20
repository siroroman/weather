//
//  RoundButton.swift
//  WeatherApp
//
//  Created by Roman Siro on 20.06.18.
//  Copyright © 2018 Roman Siro. All rights reserved.
//

import UIKit

class RoundButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()

        layer.cornerRadius = frame.height / 2
        backgroundColor = UIColor.white
        setTitleColor(UIColor.black, for: .normal)
    }

}
