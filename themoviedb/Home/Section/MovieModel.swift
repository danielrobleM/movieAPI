//
//  movieItem.swift
//  themoviedb
//
//  Created by Daniel Roble on 3/5/19.
//  Copyright © 2019 Daniel Roble. All rights reserved.
//

import IGListKit
import Foundation

final class MovieModel: NSObject, Codable {

    var id: Int = 0
    var title: String = ""
    var posterURL: String = ""
    var voteAverage: Float = 0.0
    var releaseDate: String = ""
    var overview: String = ""

    private enum MovieModelKey: String, CodingKey {
        case id = "id"
        case title = "title"
        case posterURL = "poster_path"
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
        case overview = "overview"
    }

    convenience init(id: Int, title: String, posterURL: String, voteAverage: Float, releaseDate: String, overview: String) {
        self.init()
        self.id = id
        self.title = title
        self.posterURL = posterURL
        self.voteAverage = voteAverage
        self.releaseDate = releaseDate
        self.overview = overview
    }

    convenience required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieModelKey.self)
        let id = try container.decode(Int.self, forKey: .id)
        let title = try container.decode(String.self, forKey: .title)
        let posterURL = try container.decode(String.self, forKey: .posterURL)
        let voteAverage = try container.decode(Float.self, forKey: .voteAverage)
        let releaseDate = try container.decode(String.self, forKey: .releaseDate)
        let overview = try container.decode(String.self, forKey: .overview)
        self.init(id: id, title: title, posterURL: posterURL, voteAverage: voteAverage, releaseDate: releaseDate, overview: overview)
    }

    required override init() {
        super.init()
    }
}

extension MovieModel: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return "\(id.hashValue)\(title.hashValue)" as NSString
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let other = object as? MovieModel else { return false }
        return id == other.id && title == other.title && posterURL == other.posterURL && releaseDate == other.releaseDate
    }
}

extension MovieModel {
    func getImageURL() -> URL? {
        let stringUrl = "https://image.tmdb.org/t/p/w500" + self.posterURL
        return URL(string: stringUrl)
    }
}


class ResponseMovieDB: NSObject, Codable {
    var results: [MovieModel] = []

    private enum ResponseMovieDBKey: String, CodingKey {
        case results = "results"
    }

    convenience init(results: [MovieModel]) {
        self.init()
        self.results = results
    }

    convenience required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ResponseMovieDBKey.self)
        let results = try container.decode([MovieModel].self, forKey: .results)
        self.init(results: results)
    }

    required override init() {
        super.init()
    }

}
