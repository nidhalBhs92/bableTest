//
//  HomePageModel.swift
//  MyForcast
//
//  Created by Nidhal on 21/2/2022.
//

import Foundation

struct HomePageModel {
    var fullListForcast: [WeatherResponse] = []
    var  filtredList: [WeatherResponse] = []
    
    var selectedCities: [CityModel] = []
}
