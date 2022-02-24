//
//  CityLocationResponse.swift
//  MyForcast
//
//  Created by Nidhal on 21/2/2022.
//

import Foundation

// MARK: - CityLocationResponse
struct CityLocationResponse: Codable {
    var searchAPI: SearchAPI?

    enum CodingKeys: String, CodingKey {
        case searchAPI = "search_api"
    }
}

// MARK: - SearchAPI
struct SearchAPI: Codable {
    let result: [ResultCity]
}

// MARK: - ResultCity
struct ResultCity: Codable {
    let areaName, country, region: [AreaName]
    let latitude, longitude, population: String
    let weatherURL: [AreaName]

    enum CodingKeys: String, CodingKey {
        case areaName, country, region, latitude, longitude, population
        case weatherURL = "weatherUrl"
    }
}

// MARK: - AreaName
struct AreaName: Codable {
    let value: String
}
