//
//  DetailMovieInteractor.swift
//  themoviedb
//
//  Created by Daniel Roble on 3/6/19.
//  Copyright (c) 2019 Daniel Roble. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol DetailMovieBusinessLogic {
    func displayUI(request: DetailMovie.UI.Request)
}

protocol DetailMovieDataStore {
    var movie: MovieModel { get set }
}

class DetailMovieInteractor: DetailMovieBusinessLogic, DetailMovieDataStore {
    var movie = MovieModel()

    var presenter: DetailMoviePresentationLogic?

    // MARK: DisplayUI
    func displayUI(request: DetailMovie.UI.Request) {
        guard let url = movie.getImageURL() else { return }
        let response = DetailMovie.UI.Response(title: movie.title,
                                               posterURL: url,
                                               voteAverage: movie.voteAverage.description,
                                               releaseDate: movie.releaseDate,
                                               overview: movie.overview)
        presenter?.presentUI(response: response)
    }
}
