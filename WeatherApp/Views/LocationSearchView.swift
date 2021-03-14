//
//  LocationSearchView.swift
//  WeatherApp
//
//  Created by Gourav on 14/02/21.
//

import SwiftUI

struct LocationSearchView: View
{
    @ObservedObject var cityVM:CityVM
    
    @State private var isEditing = false
    
    @State private var searchTerm = "Mumbai"
    var body: some View {
        HStack{
    
            TextField("Search ...", text: $searchTerm)
                .padding(7)
                .padding(.horizontal, 35)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }
 
            if isEditing {
                Button(action: {
                    self.isEditing = false
                    cityVM.city = searchTerm
                    self.searchTerm = ""
                    hideKeyboard()
                   
                }) {
                   // Text("Go")
                    Image(systemName: "location.fill")
                        .foregroundColor(.black)
                }
                .padding(.trailing, 30)
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
        }.overlay(
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .padding(.leading,25)
                  
         
                if isEditing {
                    Button(action: {
                       
                        
                       
                    }) {
                        
                            
                    }
                }
            }
        ) .padding(.top)

    }
}

struct MenuHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchView(cityVM: CityVM())
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
