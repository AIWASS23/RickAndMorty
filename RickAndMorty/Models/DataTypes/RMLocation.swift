//
//  File.swift
//  RickAndMorty
//
//  Created by Marcelo De Araújo on 07/01/23.
//

import Foundation

struct RMLocation: Codable {
    
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
    let created: String
}

