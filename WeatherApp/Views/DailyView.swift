//
//  DailyWeatherView.swift
//  WeatherApp
//
//  Created by Gourav on 14/02/21.
//

import SwiftUI

struct DailyView: View {
    @ObservedObject var cityVM:CityVM
    var body: some View {
        ForEach(cityVM.weather.daily){ weather in
            LazyVStack{
                dailyCell(weather: weather).padding([.horizontal])
            }
        }
    }
    private func dailyCell(weather:DailyWeather) -> some View{
        HStack{
            Text(cityVM.getDayFor(timpStamp: weather.dt).uppercased())
                .frame(width:50)
            Spacer()
            Text("MAX: \(cityVM.getTempFor(temp: weather.temp.max))\nMIN: \(cityVM.getTempFor(temp: weather.temp.min))")
                .frame(width:150)
            Spacer()
            cityVM.getWeatherIconFor(icon: weather.weather.count > 0 ? weather.weather[0].icon : "sun.max.fill")
        }.foregroundColor(.white)
        .padding(.horizontal,40)
        .padding(.vertical,15)
        .background(RoundedRectangle(cornerRadius: 12).fill(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)).opacity(0.3)))
        .shadow(color: Color.white.opacity(0.1), radius: 2, x: -2, y: -2)
        .shadow(color: Color.black.opacity(0.2), radius: 2, x: 2, y: 2)
    }
}

struct DailyWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        DailyView(cityVM: CityVM())
    }
}
