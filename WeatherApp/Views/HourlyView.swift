//
//  HourlyWeatherView.swift
//  WeatherApp
//
//  Created by Gourav on 14/02/21.
//

import SwiftUI

struct HourlyView: View {
    @ObservedObject var cityVM : CityVM
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false, content: {
            HStack(spacing:20){
                ForEach(cityVM.weather.hourly){ weather in
                    let image = cityVM.getWeatherIconFor(icon: cityVM.weatherIcon)
                    let hour = cityVM.getTimeFor(timeStamp: weather.dt)
                    let temp = cityVM.getTempFor(temp:  weather.temp)
                    getHourlyView(hour: hour, image: image, temp: temp)
                }
            }
        }).padding()
    }
    
    private func getHourlyView(hour:String,image:Image,temp:String)->some View{
        VStack(spacing:20){
            Text(hour)
            image.foregroundColor(.yellow)
            Text(temp)
        }
        .foregroundColor(.white)
        .padding(.all,10)
        .background(RoundedRectangle(cornerRadius: 12).fill(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)).opacity(0.3)))        .shadow(color: Color.white.opacity(0.1), radius: 2, x: -2, y: -2)
        .shadow(color: Color.black.opacity(0.2), radius: 2, x: 2, y: 2)
        .animation(Animation.easeInOut(duration: 2).delay(0.9))
    }
}

struct HourlyWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        HourlyView(cityVM: CityVM())
    }
}
