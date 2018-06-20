//
//  ViewController.swift
//  WeatherApp
//
//  Created by Roman Siro on 19.06.18.
//  Copyright © 2018 Roman Siro. All rights reserved.
//

import UIKit

class WeatherVC: UIViewController, UICollectionViewDataSource {

    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let viewModel = WeatherVM()

    override func viewDidLoad() {
        super.viewDidLoad()

        resetLabelTexts()
        viewModel.didUpdateData = reloadData
        viewModel.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "MapVCSegue" else {return}
        guard let destinationVC = segue.destination as? MapVC else {return}
        guard let coordinate = viewModel.currentCoordinate else {return}
        destinationVC.viewModel = MapVM(coordinate: coordinate)
    }

    private func reloadData() {
        placeLabel.text = viewModel.currentWeather.place
        timeLabel.text = viewModel.currentWeather.time
        temperatureLabel.text = viewModel.currentWeather.temperature
        icon.image = UIImage(named: viewModel.currentWeather.iconName)

        collectionView.reloadData()
    }

    private func resetLabelTexts() {
        let labels: [UILabel] = [placeLabel, timeLabel, temperatureLabel]
        labels.forEach {$0.text = nil}
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.cellData = viewModel.currentWeather.detailItems[indexPath.item]
        return cell
    }
    
}



