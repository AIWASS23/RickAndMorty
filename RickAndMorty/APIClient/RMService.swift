//
//  RMService.swift
//  RickAndMorty
//
//  Created by Marcelo De Araújo on 07/01/23.
//

import Foundation

final class RMService {

    static let shared = RMService()

    private init() {}

    public func execute(_ request: RMRequest, completion: @escaping () -> Void) {

    }
}
