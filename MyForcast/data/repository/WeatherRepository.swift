//
//  WeatherRepository.swift
//  MyForcast
//
//  Created by Nidhal on 21/2/2022.
//

import Foundation
import Alamofire

class WeatherRepository {
    static let sharedInstance = WeatherRepository()
    
    func callGetListWeatherByListCities(list: [CityModel],
                                        completion: @escaping((_ success: Bool,
                                                               _ list: [WeatherResponse],
                                                               _ error: String?) -> Void)) {
        var listWeather: [WeatherResponse] = []
        list.forEach { cityModel in
            self.callGetListWeathersLonLat(lon: "\(cityModel.lon)",
                                           lat: "\(cityModel.lat)") { _, model, error in
                var model = model
                model?.cityName = cityModel.name
                model?.id = cityModel.id
                model?.districtName = cityModel.subName
                
                listWeather.append(model ?? .init(id: -9999))
                if listWeather.count == list.count {
                    listWeather = listWeather.filter({$0.id != -9999})
                    completion(true, listWeather, error)
                }
            }
            
        }
    }
    
    func callGetListWeathersLonLat(lon: String,
                                   lat: String,
                                   completion: @escaping((_ success: Bool,
                                                          _ model: WeatherResponse?,
                                                          _ error: String?) -> Void)) {
        let params: [String: Any] = [
            Constants.latKey: lat,
            Constants.lonKey: lon,
            Constants.unitsKey: "metric",
            Constants.apiIdKey: Constants.apiWeatherId
        ]
        let headers: [String: String] = [:]
        apiRequest(url: Constants.getListWeathersPath,
                   params: params,
                   headers: headers) { success, response, statusCode in
            guard statusCode.isValidStatusCode() else {
                completion(false, nil, Constants.msgErrorServer)
                return
            }
            let decoder = JSONDecoder()
            do {
                let res = try decoder.decode(WeatherResponse.self, from: response as! Data)
                completion(true, res, nil)
            } catch {
                // parse object to specific ErrorModel to get the exact issue
                completion(false, nil, Constants.msgErrorServer)
            }
            
        }
    }
    
    func searchListCitiesByName(value: String, completion: @escaping((_ listCities: [ResultCity]) -> Void)) {
        let params: [String: Any] = [
            Constants.citySearchKey: value,
            Constants.formatResponseKey: "json",
            Constants.worldWeatherApiKey: Constants.worldWeatherApiId
        ]
        let headers: [String: String] = [:]
        apiRequest(url: Constants.pathSearchCity,
                   params: params,
                   headers: headers) { success, response, statusCode in
            guard statusCode.isValidStatusCode() else {
                completion([])
                return
            }
            let decoder = JSONDecoder()
            do {
                let res = try decoder.decode(CityLocationResponse.self, from: response as! Data)
                completion(res.searchAPI?.result ?? [])
            } catch {
                // parse object to specific ErrorModel to get the exact issue
                completion([])
            }
            
        }
    }
}
