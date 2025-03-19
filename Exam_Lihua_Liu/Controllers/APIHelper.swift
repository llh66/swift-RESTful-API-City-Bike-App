//
//  APIHelper.swift
//  Exam_Lihua_Liu
//
//  Created by LLH on 2025-03-12.
//

import Foundation
import Alamofire

class APIHelper: ObservableObject {
    @Published var networks = [Network]()
    
    func fetchNetworks() {
        let apiURL = "https://api.citybik.es/v2/networks"
        
        AF.request(apiURL)
            .validate()
            .response { resp in
                switch resp.result {
                case .success(let apiResponse):
                    do {
                        let jsonData = try JSONDecoder().decode(Networks.self, from: apiResponse!)
                        self.networks = jsonData.networks
                    } catch {
                        print("Decoding Networks Failed \(error.localizedDescription)")
                    }
                    
                case .failure(let error):
                    print("Fetching Networks failed \(error.localizedDescription)")
                }
            }
    }
}
