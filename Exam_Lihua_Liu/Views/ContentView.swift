//
//  ContentView.swift
//  Exam_Lihua_Liu
//
//  Created by LLH on 2025-03-12.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var apiHelper = APIHelper()
    @ObservedObject var fireDBHelper = FireDBHelper.getInstance()
    
    var body: some View {
        TabView {
            Tab("Locations", systemImage: "bicycle") {
                NetworkListView()
                    .navigationTitle("Locations")
            }
            
            Tab("Favorites", systemImage: "heart.fill") {
                FavoriteListView()
            }
        }
        .environmentObject(apiHelper)
        .environmentObject(fireDBHelper)
        
        .onAppear() {
            self.apiHelper.fetchNetworks()
            self.fireDBHelper.getFavoriteList()
        }
    }
}
