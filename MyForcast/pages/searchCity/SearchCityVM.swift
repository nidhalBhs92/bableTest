//
//  SearchCityVM.swift
//  MyForcast
//
//  Created by Nidhal on 21/2/2022.
//

import Foundation

class SearchCityVM {
    
    var model = SearchCityModel()
    
    func searchForCityByName(value: String, completion: @escaping(() -> Void)) {
        WeatherRepository.sharedInstance.searchListCitiesByName(value: value) { listCities in
            self.model.listCities = listCities
            completion()
        }
    }
    
    /*
     This function will be used on the VC to the get the current list
     */
    func getListCitiesItems() -> [ResultCity] {
        return self.model.listCities
    }
    
    /*
     This function will get an item at index
     */
    func getItemAtIndexOf(index: Int) -> ResultCity? {
        guard index >= 0 && index < self.model.listCities.count else {
            return nil
        }
        return self.model.listCities[index]
    }
}
