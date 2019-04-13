//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Nelson Gonzalez on 4/13/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    let weatherController = WeatherController()
    
    var weather: [Forecast]? = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else {return}
        
        weatherController.getWeatherWith(cityName: searchTerm) { (weather, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let weather = weather else {return}
            
            self.weather = weather
            
        }
        
        
    }
    
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return weather?.count ?? 1 //weatherController.forecast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weatherCell", for: indexPath) as! WeatherCollectionViewCell
        
        let weather = self.weather?[indexPath.row]
        
        cell.weather = weather
        
        return cell
    }

}
