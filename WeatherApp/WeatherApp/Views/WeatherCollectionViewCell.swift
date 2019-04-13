//
//  WeatherCollectionViewCell.swift
//  WeatherApp
//
//  Created by Nelson Gonzalez on 4/13/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    
    var weather: Forecast? {
        didSet {
            updateViews()
        }
    }
    
    private func updateViews() {
        guard let weather = weather else {return}
        cityNameLabel.text = weather.city.name
       // let temp = weather.list.map({$0.main.temp})
        temperatureLabel.text = "\(weather.list[0].main.temp)"
       // temperatureLabel.text = "\(temp)"
        weatherIconImageView.image = UIImage(named: weather.list[0].weather[0].icon)
    }
}
