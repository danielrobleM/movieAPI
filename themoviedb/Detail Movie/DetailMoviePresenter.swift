//
//  DetailMoviePresenter.swift
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

protocol DetailMoviePresentationLogic {
    func presentUI(response: DetailMovie.UI.Response)
}

class DetailMoviePresenter: DetailMoviePresentationLogic {
    weak var viewController: DetailMovieDisplayLogic?

    func presentUI(response: DetailMovie.UI.Response) {
        let viewModel = DetailMovie.UI.ViewModel(title: response.title,
                                               posterURL: response.posterURL,
                                               voteAverage: response.voteAverage.description,
                                               releaseDate: response.releaseDate,
                                               overview: response.overview)
        viewController?.presentUI(viewModel: viewModel)
    }
}
