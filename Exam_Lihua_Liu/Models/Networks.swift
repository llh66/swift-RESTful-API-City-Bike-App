//
//  Networks.swift
//  Exam_Lihua_Liu
//
//  Created by LLH on 2025-03-12.
//

import Foundation

struct Networks: Codable {
    let networks: [Network]
}

struct Network: Identifiable, Codable {
    var id = UUID().uuidString
    let name: String
    let location: Location
    let href: String
    let company: [String]
}

struct Location: Codable {
    let latitude: Double
    let longitude: Double
    let city: String
    let country: String
}
