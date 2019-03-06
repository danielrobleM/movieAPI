//
//  HomeViewController.swift
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
import IGListKit

protocol HomeDisplayLogic: class {
    func displayUI(viewModel: Home.UI.ViewModel)
    func displayActionSheet(viewModel: Home.ActionSheet.ViewModel)
}

class HomeViewController: UIViewController, HomeDisplayLogic {
    var interactor: HomeBusinessLogic?
    var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?
    var movieSection: [MovieModel] = []

    // MARK: Object lifecycle
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 2)
    }()

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    var spinner = UIActivityIndicatorView(style: .gray)


    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Setup
    private func setup() {
        let viewController = self
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: Routing
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self

        view.addSubview(spinner)
        spinner.hidesWhenStopped = true
        spinner.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        spinner.startAnimating()

        let filter = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(onFilterPress))

        navigationItem.rightBarButtonItems = [filter]

        interactor?.displayUI(request: Home.UI.Request(order: .popular))
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
        collectionView.backgroundColor = .white
    }

    // MARK: Display UI
    func displayUI(viewModel: Home.UI.ViewModel) {
        self.view.backgroundColor = .white
        self.movieSection = viewModel.movies
        self.adapter.performUpdates(animated: true) { [weak self] (finished) in
            self?.spinner.stopAnimating()
        }
    }

    // MARK: Filter
    @objc func onFilterPress() {
        interactor?.displayActionSheet(request: Home.ActionSheet.Request())
    }

    func displayActionSheet(viewModel: Home.ActionSheet.ViewModel) {
        let actionSheet = UIAlertController(title: viewModel.title,
                                            message: viewModel.message,
                                            preferredStyle: .actionSheet)

        viewModel.options.forEach {
            actionSheet.addAction(UIAlertAction(title: $0, style: .default, handler: onOptionSelected))
        }

        self.present(actionSheet, animated: true, completion: nil)
    }

    func onOptionSelected(alert: UIAlertAction!) {
        guard let title = alert.title else { return }
        interactor?.refreshMovies(title: title)
    }
}

extension HomeViewController : ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return movieSection as [ListDiffable]
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return MovieSectionController()
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}
