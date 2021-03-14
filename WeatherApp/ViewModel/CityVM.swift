//
//  CityVM.swift
//  WeatherApp
//
//  Created by Gourav on 14/02/21.
//

import Foundation
import CoreLocation
import SwiftUI

final class CityVM: ObservableObject
{
    @Published var weather = WeatherResponse.empty()
    @Published var loading = true
    @Published var city : String = "Mumbai"{
        didSet{
            self.getLocationInfo()
        }
    }
    
    private lazy var dateFormatter:DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }()
    private lazy var dayFormatter : DateFormatter = {
     let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter
    }()
    private lazy var timeFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh a"
        return formatter
    }()
    
    init() {
        getLocationInfo()
    }
    var date: String{
        return dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(weather.current.dt)))
    }
    
    var weatherIcon :String
    {
        if weather.current.weather.count > 0 {
            return weather.current.weather[0].icon
        }
        return "sun.max.fill"
    }
    var temprature:String{
        return getTempFor(temp: weather.current.temp)
    }
    var conditions :String
    {
        if weather.current.weather.count > 0 {
            return weather.current.weather[0].main
        }
        return ""
    }
    
    var windSpeed:String{
        return String(format: "%0.1f", weather.current.wind_speed)
    }
    
    var humidity:String{
        return String(format: "%d%%", weather.current.humidity)
    }
    
    var rainChances :String{
        return String(format: "%0.0f%%", weather.current.dew_point)
    }
    func getTimeFor(timeStamp:Int)->String{
        return timeFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(timeStamp)))
    }
    func getDayFor(timpStamp:Int)->String{
        return dayFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(timpStamp)))
    }
    func getTempFor(temp:Double)->String{
        let mf = MeasurementFormatter()
        mf.locale = Locale(identifier: "en_GB")
        mf.numberFormatter.maximumFractionDigits = 0
        let temp1 = Measurement(value: temp, unit: UnitTemperature.fahrenheit)
        return mf.string(from: temp1)
    }
    private func getLocationInfo(){
        CLGeocoder().geocodeAddressString(city) { (placemarks, error) in
            if let places = placemarks, let place = places.first{
                self.getWeather(coord: place.location?.coordinate)
            }
        }
    }
   
    private func getWeather(coord:CLLocationCoordinate2D?){
        if let coord = coord{
            let urlString = API.getURLFor(lat: coord.latitude, long: coord.longitude)
            self.getWeatherInternal(city: city, for: urlString)
        }else{
            let urlString = API.getURLFor(lat: 19.0760, long: 72.8777)
            self.getWeatherInternal(city: city, for: urlString)
        }
        
    }

    private func getWeatherInternal(city:String,for urlString:String){
        APIManager<WeatherResponse>.fetch(for: URL(string: urlString)!) { (result) in
            switch result{
            case .success(let response):
                print(response)
             
                DispatchQueue.main.async {
                    self.loading = false
                    self.weather = response
                }
            case .failure(let err):
                print(err   )
            }
        }
    }
    
    func getLottieAnimationFor(icon:String)->String
    {
        switch icon
        {
        case "01d":
            return "35627-weather-day-clear-sky"
        case "01n":
            return "35781-weather-night-clear-sky"
        case "02d":
            return "35779-weather-day-few-clouds"
        case "02n":
            return "35779-weather-night-few-clouds"
        case "03d":
            return "35778-weather-night-scattered-clouds"
        case "03n":
            return "35631-weather-day-scattered-clouds"
        case "04d":
            return "35631-weather-day-scattered-clouds"
        case "04n":
            return "35774-weather-night-shower-rains"
        case "09d":
            return "35774-weather-night-shower-rains"
        case "09n":
            return "35755-weather-night-thunderstorm"
        case "10n":
            return "35755-weather-night-thunderstorm"
        case "11d":
            return "35724-weather-night-rain"
        case "11n":
            return "35724-weather-night-rain"
        case "13d":
            return "35743-weather-day-snow"
        case "13n":
            return "35743-weather-night-snow"
        case "50d":
            return "35724-weather-night-rain"
        case "50n":
            return "35724-weather-day-rain"

        default:
            return "35627-weather-day-clear-sky"
        }
    }
    
    func getWeatherIconFor(icon:String)->Image{
        switch icon {
        case "01d":
            return Image(systemName:"sun.max.fill")
        case "01n":
            return Image(systemName:"moon.fill")
        case "02d":
            return Image(systemName:"cloud.sun.fill")
        case "02n":
            return Image(systemName:"cloud.moon.fill")
        case "03d":
            return Image(systemName:"cloud.fill")
        case "03n":
            return Image(systemName:"cloud.fill")
        case "04d":
            return Image(systemName:"cloud.fill")
        case "04n":
            return Image(systemName:"cloud.drizzle.fill")
        case "09d":
            return Image(systemName:"cloud.drizzle.fill")
        case "09n":
            return Image(systemName:"cloud.heavyrain.fill")
        case "10n":
            return Image(systemName:"cloud.heavyrain.fill")
        case "11d":
            return Image(systemName:"cloud.bolt.fill")
        case "11n":
            return Image(systemName:"cloud.bolt.fill")
        case "13d":
            return Image(systemName:"cloud.snow.fill")
        case "13n":
            return Image(systemName:"cloud.snow.fill")
        case "50d":
            return Image(systemName:"cloud.sun.bolt")
        case "50n":
            return Image(systemName:"cloud.sun.bolt")
        default:
            return Image(systemName:"cloud.sun.fill")
        }
    }
}
