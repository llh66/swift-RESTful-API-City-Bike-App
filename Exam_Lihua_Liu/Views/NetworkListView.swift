//
//  NetworkList.swift
//  Exam_Lihua_Liu
//
//  Created by LLH on 2025-03-12.
//

import SwiftUI

struct NetworkListView: View {
    
    @EnvironmentObject var apiHelper: APIHelper
    @EnvironmentObject var fireDBHelper: FireDBHelper
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(searchResults, id: \.id) { network in
                    NavigationLink(destination: DetailView(network: network)) {
                        Text(network.location.city)
                    }
                }
            }
            .searchable(text: $searchText)
            .navigationTitle(Text("Locations"))
        }
    }
    
    private var searchResults: [Network] {
        if searchText.isEmpty {
            return self.apiHelper.networks
        } else {
            return self.apiHelper.networks.filter {
                $0.location.city.range(of: self.searchText, options: [.caseInsensitive, .diacriticInsensitive]) != nil
            }
        }
    }
}
