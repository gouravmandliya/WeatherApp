//
//  DailyWeather.swift
//  WeatherApp
//
//  Created by Gourav on 14/02/21.
//

import Foundation

struct DailyWeather:Codable,Identifiable {
    var dt:Int
    var temp :Temprature
    var weather: [WeatherDetail]
    enum Codingkey:String
    {
        case dt
        case temp
        case weather
        
    }
    init() {
        dt = 0
        temp  = Temprature(min: 0.0, max: 0.0)
        weather = [WeatherDetail(main: "", description: "", icon: "")]
    }
}

extension DailyWeather{
    var id :UUID{
        return UUID()
    }
}

struct Temprature:Codable
{
    var min:Double
    var max:Double
}
