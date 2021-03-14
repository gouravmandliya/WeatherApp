//
//  CityView.swift
//  WeatherApp
//
//  Created by Gourav on 14/02/21.
//

import SwiftUI

struct CityView: View {
    @ObservedObject var cityVM : CityVM
    @State var isLoading:Bool = true
    var body: some View {
        
        ZStack
        {
            VStack
            {
                ScrollView(){
                    LocationSearchView(cityVM: cityVM)
                    CityNameView(city: cityVM.city, date: cityVM.date)
                    TodayView(cityVM: cityVM)
                    Text("Hourly Report").font(.title).fontWeight(.bold).foregroundColor(.white)
                    HourlyView(cityVM: cityVM)
                    Text("Daily Report").font(.title).fontWeight(.bold).foregroundColor(.white)
                    DailyView(cityVM: cityVM)
                }
            }
        }
      
    }
}

struct CityView_Previews: PreviewProvider {
    static var previews: some View {
        CityView(cityVM: CityVM())
    }
}


