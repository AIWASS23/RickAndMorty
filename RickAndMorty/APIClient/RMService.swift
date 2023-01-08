//
//  RMService.swift
//  RickAndMorty
//
//  Created by Marcelo De Araújo on 07/01/23.
//

import Foundation

final class RMService {

    static let shared = RMService()

    private let cacheManager = RMAPICacheManager()

    private init() {}

    enum RMServiceError: Error {
        case failedToCreateRequest
        case failedToGetData
    }

    public func execute<T: Codable>(
        _ request: RMRequest,
        expecting type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        if let cachedData = cacheManager.cachedResponse(
            for: request.endpoint,
            url: request.url
        ) {
            do {
                let result = try JSONDecoder().decode(type.self, from: cachedData)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
            return
        }

        guard let urlRequest = self.request(from: request) else {
            completion(.failure(RMServiceError.failedToCreateRequest))
            return
        }

        let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? RMServiceError.failedToGetData))
                return
            }

            do {
                let result = try JSONDecoder().decode(type.self, from: data)
                self?.cacheManager.setCache(
                    for: request.endpoint,
                    url: request.url,
                    data: data
                )
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }

    private func request(from rmRequest: RMRequest) -> URLRequest? {
        guard let url = rmRequest.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = rmRequest.httpMethod
        return request
    }
}

/*
    RMService é uma classe final em Swift que representa um serviço para fazer solicitações HTTP. 
    Ela possui uma única instância compartilhada, que é acessível através da propriedade estática "shared".

    A classe possui um inicializador privado que garante que ela não possa ser instanciada diretamente. 
    Em vez disso, a única maneira de acessar o serviço é através da propriedade "shared". A classe também 
    possui um enum aninhado chamado RMServiceError que define dois casos de erro que podem ser lançados 
    pelo serviço.

    A classe possui uma função "execute" que aceita um objeto do tipo RMRequest, um tipo genérico que deve 
    implementar o protocolo Codable e uma closure que é chamada com um resultado do tipo Result. A função 
    tenta recuperar os dados armazenados em cache para a solicitação especificada usando a propriedade 
    "cacheManager", que é uma instância da classe RMAPICacheManager. Se os dados forem encontrados em 
    cache, eles são decodificados usando o JSONDecoder e o resultado é passado para a closure de conclusão.

    Se os dados não forem encontrados em cache, a função cria uma solicitação URL a partir do objeto 
    RMRequest e a envia usando a sessão padrão de URL. Quando os dados são recebidos, eles são decodificados 
    e armazenados em cache usando o RMAPICacheManager. O resultado é então passado para a closure de 
    conclusão.
*/
