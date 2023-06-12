//
//  RMRequest.swift
//  RickAndMorty
//
//  Created by Marcelo De Araújo on 07/01/23.
//

import Foundation

final class RMRequest {

    private struct Constants {
        static let baseUrl = "https://rickandmortyapi.com/api"
    }

    let endpoint: RMEndpoint
    private let pathComponents: [String]
    private let queryParameters: [URLQueryItem]

    private var urlString: String {
        var string = Constants.baseUrl
        string += "/"
        string += endpoint.rawValue

        if !pathComponents.isEmpty {
            pathComponents.forEach({
                string += "/\($0)"
            })
        }

        if !queryParameters.isEmpty {
            string += "?"
            let argumentString = queryParameters.compactMap({
                guard let value = $0.value else { return nil }
                return "\($0.name)=\(value)"
            }).joined(separator: "&")

            string += argumentString
        }

        return string
    }

    public var url: URL? {
        return URL(string: urlString)
    }

    public let httpMethod = "GET"

    public init(
        endpoint: RMEndpoint,
        pathComponents: [String] = [],
        queryParameters: [URLQueryItem] = []
    ) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }

    convenience init?(url: URL) {
        let string = url.absoluteString
        if !string.contains(Constants.baseUrl) {
            return nil
        }
        let trimmed = string.replacingOccurrences(of: Constants.baseUrl+"/", with: "")
        if trimmed.contains("/") {
            let components = trimmed.components(separatedBy: "/")
            if !components.isEmpty {
                let endpointString = components[0] // Endpoint
                var pathComponents: [String] = []
                if components.count > 1 {
                    pathComponents = components
                    pathComponents.removeFirst()
                }
                if let rmEndpoint = RMEndpoint(
                    rawValue: endpointString
                ) {
                    self.init(endpoint: rmEndpoint, pathComponents: pathComponents)
                    return
                }
            }
        } else if trimmed.contains("?") {
            let components = trimmed.components(separatedBy: "?")
            if !components.isEmpty, components.count >= 2 {
                let endpointString = components[0]
                let queryItemsString = components[1]
                let queryItems: [URLQueryItem] = queryItemsString.components(separatedBy: "&").compactMap({
                    guard $0.contains("=") else {
                        return nil
                    }
                    let parts = $0.components(separatedBy: "=")

                    return URLQueryItem(
                        name: parts[0],
                        value: parts[1]
                    )
                })

                if let rmEndpoint = RMEndpoint(rawValue: endpointString) {
                    self.init(endpoint: rmEndpoint, queryParameters: queryItems)
                    return
                }
            }
        }

        return nil
    }
}

extension RMRequest {
    static let listCharactersRequests = RMRequest(endpoint: .character)
    static let listEpisodesRequest = RMRequest(endpoint: .episode)
    static let listLocationsRequest = RMRequest(endpoint: .location)
}

/*
RMRequest é uma classe final em Swift que representa uma solicitação HTTP. Ela possui uma estrutura 
aninhada chamada Constants que possui uma propriedade de classe estática chamada "baseUrl", que é 
usada como base para a URL da solicitação.

A classe possui um inicializador designado que permite criar uma instância da classe passando 
um objeto do tipo RMEndpoint, que é um tipo enum que representa o endpoint da API, um array de strings 
opcional com os componentes de caminho da URL, e um array de objetos do tipo URLQueryItem opcional 
com os parâmetros de consulta da URL. A classe também possui um inicializador de conveniência que 
permite criar uma instância da classe a partir de uma URL, desmembrando-a em seus componentes e construindo 
um objeto do tipo RMRequest com base nesses componentes.

A classe possui uma propriedade de instância chamada "httpMethod" que é sempre iniciada como "GET". 
Ela também possui uma propriedade de instância chamada "url" que é uma URL opcional que é construída 
com base na propriedade "endpoint", os componentes de caminho e os parâmetros de consulta.

A classe possui uma extensão que possui três propriedades estáticas, cada uma delas é uma instância da 
classe RMRequest com diferentes combinações de endpoint e parâmetros de consulta. Essas propriedades são 
usadas para criar solicitações específicas para cada endpoint da API.
*/