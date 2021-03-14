//
//  TodayView.swift
//  WeatherApp
//
//  Created by Gourav on 14/02/21.
//

import SwiftUI


struct TodayView: View {
    @ObservedObject var cityVM : CityVM
    var body: some View{
        VStack(spacing:10){
            
            Text("Today")
                .font(.largeTitle)
                .bold()
            LottieView(name: self.cityVM.getLottieAnimationFor(icon: cityVM.weatherIcon))
            HStack(spacing:20){
                VStack(alignment: .leading, content: {
                    Text("\(cityVM.temprature)")
                        .font(.system(size: 42))
                    Text(cityVM.conditions)
                })
                HStack{
                    Spacer()
                    widgetView(image: "wind", color: .green, title: "\(cityVM.windSpeed)mi/hr")
                    Spacer()
                    widgetView(image: "drop.fill", color: .blue, title: "\(cityVM.humidity)")
                    Spacer()
                    widgetView(image: "umbrella.fill", color: .red, title: "\(cityVM.rainChances)")
                    Spacer()
                }
            }
           
        }
        .padding()
        .foregroundColor(.white)
      
        .shadow(color: Color.white.opacity(0.1), radius: 2, x: -2, y: -2)
        .shadow(color: Color.black.opacity(0.2), radius: 2, x: 2, y: 2)
        .padding()
        .frame(height:550)
    }
    

    private func widgetView(image:String,color:Color,title:String) -> some View{
        VStack{
            Image(systemName: image)
                .padding()
                .font(.title)
                .foregroundColor(color)
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
            Text(title)
        }
    }
}

struct TodayWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        TodayView(cityVM: CityVM())
            .previewLayout(.sizeThatFits)
    }
}
