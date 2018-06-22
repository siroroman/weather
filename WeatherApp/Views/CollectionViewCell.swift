//
//  CollectionViewCell.swift
//  WeatherApp
//
//  Created by Roman Siro on 20.06.18.
//  Copyright © 2018 Roman Siro. All rights reserved.
//

import UIKit

struct WeatherDetailItem {

    let imageName: String
    let descriptionText: String
    let valueText: String

}

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!

    var cellData: WeatherDetailItem? {
        didSet {
            iconImageView.image = UIImage(named: cellData?.imageName ?? "")?.withRenderingMode(.alwaysTemplate)
            topLabel.text = cellData?.descriptionText
            bottomLabel.text = cellData?.valueText
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.150000006)
        layer.cornerRadius = 4
        clipsToBounds = true
    }
    
}
