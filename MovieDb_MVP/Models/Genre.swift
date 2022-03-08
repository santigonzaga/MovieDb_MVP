//
//  Genre.swift
//  MovieDb_MVP
//
//  Created by Santiago del Castillo Gonzaga on 04/03/22.
//

import Foundation

struct GenreResult: Codable {
    let genres: [Genre]
}

struct Genre: Codable {
    let id: Int
    let name: String
}
