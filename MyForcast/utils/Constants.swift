//
//  Constants.swift
//  MyForcast
//
//  Created by Nidhal on 21/2/2022.
//

import Foundation

class Constants {
    static let apiWeatherId         = "5d39406e9c6a057a30818ebece1667da"
    static let worldWeatherApiId    = "c5c493b1bb15468981a192805222002"
    
    static let baseUrl              = "https://api.openweathermap.org/"
    static let pathImgIcon          = "https://openweathermap.org/img/wn/**_**@2x.png"
    static let getListWeathersPath  = baseUrl + "data/2.5/onecall"
    
    static let baseUrlWorldWeather  = "https://api.worldweatheronline.com/"
    static let pathSearchCity       = baseUrlWorldWeather + "premium/v1/search.ashx"
    
    static let msgErrorServer       = "Erreur Server"
    
    static let latKey               = "lat"
    static let lonKey               = "lon"
    static let apiIdKey             = "appid"
    static let unitsKey             = "units"
    
    static let citySearchKey        = "q"
    static let formatResponseKey    = "format"
    static let worldWeatherApiKey   = "key"
    
}
