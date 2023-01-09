//
//  RMGetAllCharactersResponse.swift
//  RickAndMorty
//
//  Created by Marcelo De Araújo on 07/01/23.
//

import Foundation

struct RMGetAllCharactersResponse: Codable {
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }

    let info: Info
    let results: [RMCharacter]
}

/*
    RMGetAllCharactersResponse, que é usada para armazenar informações sobre uma resposta de uma 
    solicitação de rede para obter todos os personagens da API.

    A struct tem uma propriedade interna chamada info, que é do tipo Info, que por sua vez é outra 
    estrutura. A estrutura Info tem quatro propriedades: count (um inteiro que indica o número total de 
    personagens), pages (um inteiro que indica o número total de páginas de resultados), 
    next (uma string opcional que contém a URL da próxima página de resultados, se houver) e 
    prev (uma string opcional que contém a URL da página de resultados anterior, se houver).

    A struct RMGetAllCharactersResponse também tem uma propriedade chamada results, que é uma matriz de 
    objetos do tipo RMCharacter.

    A struct RMGetAllCharactersResponse implementa o protocolo Codable, o que significa que pode ser 
    codificada em um formato de dados (como JSON) e decodificada a partir desse formato de dados. 
    Isso é útil quando você deseja enviar ou receber esses dados usando uma solicitação de rede.



*/