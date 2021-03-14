//
//  ContentView.swift
//  WeatherApp
//
//  Created by Gourav on 14/02/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var cityVM = CityVM()
    var body: some View {
        ZStack(alignment:.bottom){
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)),Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing:0){
                ScrollView(showsIndicators:false){
                    CityView(cityVM: cityVM)
                        .edgesIgnoringSafeArea(.all)

                }
            }
            
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
