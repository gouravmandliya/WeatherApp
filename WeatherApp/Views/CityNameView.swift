//
//  CityNameView.swift
//  WeatherApp
//
//  Created by Gourav on 14/02/21.
//

import SwiftUI

struct CityNameView: View {
    var city:String
    var date:String
    var body: some View {
        HStack{
            VStack(alignment: .center, spacing: 10, content: {
                Text(city)
                    .font(.title)
                    .bold()
                Text(date)
            })
            .foregroundColor(.white)
        }
    }
}

struct CityNameView_Previews: PreviewProvider {
    static var previews: some View {
        CityNameView(city: "dfd", date: "dfdf")
    }
}
