//
//  HomeModels.swift
//  themoviedb
//
//  Created by Daniel Roble on 3/5/19.
//  Copyright (c) 2019 Daniel Roble. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum orderBy: String{
    case popular = "Popular"
    case topRated = "Top rated"
    static let allValues = [popular, topRated]

    var stringUrl: String {
        switch self {
        case .topRated:
            return "https://api.themoviedb.org/3/movie/top_rated?api_key=34738023d27013e6d1b995443764da44"
        default:
            return "https://api.themoviedb.org/3/movie/popular?api_key=34738023d27013e6d1b995443764da44"
        }
    }
}

enum Home {
    // MARK: UI
    enum UI {
        struct Request {
            let order: orderBy
        }
        struct Response {
            let movies: [MovieModel]
        }
        struct ViewModel {
            let movies: [MovieModel]
        }
    }

    enum ActionSheet {
        struct Request {}
        struct Response {
            let title: String
            let message: String
            let options: [String]
        }
        struct ViewModel {
            let title: String
            let message: String
            let options: [String]
        }
    }
}