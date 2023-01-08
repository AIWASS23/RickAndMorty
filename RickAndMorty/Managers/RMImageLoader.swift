//
//  RMImageLoad.swift
//  RickAndMorty
//
//  Created by Marcelo De Araújo on 07/01/23.
//

import Foundation

final class RMImageLoader {
    static let shared = RMImageLoader()

    private var imageDataCache = NSCache<NSString, NSData>()

    private init() {}

    public func downloadImage(_ url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        let key = url.absoluteString as NSString
        if let data = imageDataCache.object(forKey: key) {
            completion(.success(data as Data))
            return
        }

        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            let value = data as NSData
            self?.imageDataCache.setObject(value, forKey: key)
            completion(.success(data))
        }
        task.resume()
    }
}

/*
    RMImageLoader é uma classe final em Swift que faz o download de imagens a partir de URLs. Ela possui 
    uma propriedade de instância chamada "imageDataCache" que é um objeto do tipo NSCache que é usado para 
    armazenar em cache os dados de imagem baixados.

    A classe possui uma única função pública chamada "downloadImage" que aceita uma URL e uma closure de 
    conclusão como parâmetros. A função primeiro verifica se o dado da imagem está em cache usando o 
    "imageDataCache" e, se estiver, chama a closure de conclusão com os dados em cache. Caso contrário, 
    ela cria uma solicitação de URL e inicia uma tarefa de sessão de rede para fazer o download dos dados 
    da imagem. Quando os dados são recebidos, eles são armazenados em cache e a closure de conclusão é 
    chamada com os dados baixados.
*/
