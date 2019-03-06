//
//  movieSectionController.swift
//  themoviedb
//
//  Created by Daniel Roble on 3/5/19.
//  Copyright © 2019 Daniel Roble. All rights reserved.
//

import IGListKit
import Foundation
import SDWebImage

final class MovieSectionController: ListSectionController {
    private var movie: MovieModel?
    override init() {
        super.init()
    }

    override func didUpdate(to object: Any) {
        guard let model = object as? MovieModel else { return }
        self.movie = model
    }
}

extension MovieSectionController {
    override func numberOfItems() -> Int {
        return movie == nil ? 0 : 1
    }

    override func sizeForItem(at index: Int) -> CGSize {
        guard let context = collectionContext else { return CGSize.zero }
        return CGSize(width: context.containerSize.width, height: 150)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cellClass = MovieCollectionViewCell.self
        guard let context = collectionContext, let cell = context.dequeueReusableCell(of: cellClass, for: self, at: index) as? MovieCollectionViewCell, let movie = self.movie else { assertionFailure("collection context is nil"); return UICollectionViewCell() }

        cell.titleLabel.text = movie.title
        cell.releaseDateLabel.text = movie.releaseDate
        cell.voteAverageLabel.text = movie.voteAverage.description

        if let url = movie.getImageURL() {
            cell.posterImageView.sd_setImage(with: url, completed: nil)
        }

        return cell
    }
}
