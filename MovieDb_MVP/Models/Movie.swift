//
//  Movie.swift
//  MovieDb_MVP
//
//  Created by Santiago del Castillo Gonzaga on 04/03/22.
//

import UIKit

struct Movie: Codable {
    let id: Int
    let title: String
    let vote_average: Float
    let overview: String?
    let poster_path: String?
    let genres: [Int]
}
