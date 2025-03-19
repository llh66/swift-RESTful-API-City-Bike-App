//
//  FavoriteListView.swift
//  Exam_Lihua_Liu
//
//  Created by LLH on 2025-03-12.
//

import SwiftUI

struct FavoriteListView: View {
    
    @EnvironmentObject var apiHelper: APIHelper
    @EnvironmentObject var fireDBHelper: FireDBHelper
    
    @State var showAlert: Bool = false
    @State var selectedLocation: String = ""
    
    var body: some View {
        NavigationStack {
            List {
                
                if self.favoriteList.isEmpty {
                    Text("Empty Favorite List, you may add some first!")
                        .foregroundColor(.gray)
                        .italic()
                }
                
                ForEach(self.favoriteList, id: \.id) { network in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(network.location.city)
                                .font(.title2)
                                .bold(true)
                            ForEach(network.company, id: \.self) { company in
                                Text(company)
                            }
                        }//Vstack ends
                        
                        Spacer()
                        
                        Button {
                            self.selectedLocation = network.id
                            self.showAlert = true
                        } label: {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                        .buttonStyle(.borderless)
                    }//HStack ends
                }
            } //List ends
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Confirmation"),
                      message: Text("Do you want to delete this location?"),
                      primaryButton: .default(Text("No")),
                      secondaryButton: .destructive(Text("Yes"), action: {
                    self.fireDBHelper.favoriteList.remove(at: self.fireDBHelper.favoriteList.firstIndex(of: self.selectedLocation)!)
                    self.fireDBHelper.updateFavoriteList()
                }))
            } // .alert ends
            
            .navigationTitle("Favorites")
        }
    }
    
    private var favoriteList: [Network] {
        return self.apiHelper.networks.filter { self.fireDBHelper.favoriteList.contains($0.id) }
    }
    
}
