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
        
        ZStack{
    
            VStack(spacing:0){
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
            ActivityIndicator(cityVM:cityVM, style: .large)
        }
      
    }
}
struct ActivityIndicator: UIViewRepresentable {

    @ObservedObject var cityVM:CityVM
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        cityVM.loading ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
struct CityView_Previews: PreviewProvider {
    static var previews: some View {
        CityView(cityVM: CityVM())
    }
}



struct BlurView: UIViewRepresentable {

   let style: UIBlurEffect.Style

   func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIView {
      let view = UIView(frame: .zero)
      view.backgroundColor = .clear
      let blurEffect = UIBlurEffect(style: style)
      let blurView = UIVisualEffectView(effect: blurEffect)
      blurView.translatesAutoresizingMaskIntoConstraints = false
      view.insertSubview(blurView, at: 0)
      NSLayoutConstraint.activate([
         blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
         blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
      ])
      return view
   }

   func updateUIView(_ uiView: UIView,
                     context: UIViewRepresentableContext<BlurView>) {}
}
