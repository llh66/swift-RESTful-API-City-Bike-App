//
//  DetailView.swift
//  Exam_Lihua_Liu
//
//  Created by LLH on 2025-03-12.
//

import SwiftUI
import MapKit

struct DetailView: View {
    
    let network: Network
    
    @EnvironmentObject var fireDBHelper: FireDBHelper
    
    @State private var isFavorite: Bool = false
    
    @State private var showAlert: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    
    var body: some View {
        VStack {
            Text("\(self.network.location.city), \(self.network.location.country)")
                .font(.title)
                .bold()
            ForEach(self.network.company, id: \.self) { company in
                Text(company)
            }
            
            Map {
                Marker(self.network.location.city, coordinate: CLLocationCoordinate2D(latitude: self.network.location.latitude, longitude: self.network.location.longitude))
            }
            
            Button {
                self.fireDBHelper.favoriteList.append(self.network.id)
                self.fireDBHelper.updateFavoriteList()
                self.showAlert = true
                self.isFavorite.toggle()
            } label: {
                Text(self.isFavorite ? "IN FAVORITES" : "MARK AS FAVORITE")
                    .font(.title)
            }
            .disabled(self.isFavorite)
            
            .alert(isPresented: self.$showAlert) {
                Alert(title: Text("Success"),
                      message: Text("The network has been added to your favorites"))
            }
        }
        .padding()
        .navigationTitle("Details")
        
        .onAppear() {
            self.isFavorite = self.fireDBHelper.favoriteList.contains(where: { $0 == self.network.id })
        }
    }
}
