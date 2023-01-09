//
//  RMGetAllEpisodesResponse.swift
//  RickAndMorty
//
//  Created by Marcelo De Araújo on 07/01/23.
//

import Foundation

struct RMGetAllEpisodesResponse: Codable {
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }

    let info: Info
    let results: [RMEpisode]
}

/*
    a RMGetAllEpisodesResponse, que é usada para armazenar informações sobre uma resposta de uma solicitação
    de rede para obter todos os episódios da API.

    A struct é semelhante à estrutura RMGetAllCharactersResponse que mencionei anteriormente, com uma 
    propriedade interna chamada info do tipo Info e uma propriedade chamada results que é uma matriz de 
    objetos do tipo RMEpisode. A estrutura Info também é semelhante, com propriedades para o número total 
    de episódios, o número total de páginas de resultados, a URL da próxima página de resultados (se houver)
     e a URL da página de resultados anterior (se houver).

    Como a struct RMGetAllEpisodesResponse implementa o protocolo Codable, ela pode ser codificada em um 
    formato de dados (como JSON) e decodificada a partir desse formato de dados. Isso é útil quando você 
    deseja enviar ou receber esses dados usando uma solicitação de rede.
*/