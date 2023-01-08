//
//  RMEndPoint.swift
//  RickAndMorty
//
//  Created by Marcelo De Araújo on 07/01/23.
//

import Foundation

@frozen enum RMEndpoint: String, CaseIterable, Hashable {

    case character
    case location
    case episode
    case setting
}
