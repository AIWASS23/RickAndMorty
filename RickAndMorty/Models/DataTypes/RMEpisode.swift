//
//  RMEpisode.swift
//  RickAndMorty
//
//  Created by Marcelo De Araújo on 07/01/23.
//

struct RMEpisode: Codable, RMEpisodeDataRender {
    
    let id: Int
    let name: String
    let airDate: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
}

