//
//  HomeRouter.swift
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
import FloatingPanel

@objc protocol HomeRoutingLogic {
    func routeToMovieDetail(movie: MovieModel)
}

protocol HomeDataPassing {
    var dataStore: HomeDataStore? { get }
}

class HomeRouter: NSObject, HomeRoutingLogic, HomeDataPassing {
    weak var viewController: HomeViewController?
    var dataStore: HomeDataStore?

    // MARK: Routing
    func routeToMovieDetail(movie: MovieModel) {
        let contentViewController = DetailMovieViewController()
        contentViewController.router?.dataStore?.movie = movie

//        let floatVC = FloatingPanelController()
//        floatVC.delegate = viewController!.self
//
//        floatVC.set(contentViewController: contentViewController)
//
//        //
//        floatVC.isRemovalInteractionEnabled = true

        contentViewController.modalPresentationStyle = .overCurrentContext

        viewController?.present(contentViewController, animated: true, completion: nil)
    }
}