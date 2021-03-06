
//
//  MovieCollectionViewCell.swift
//  themoviedb
//
//  Created by Daniel Roble on 3/5/19.
//  Copyright © 2019 Daniel Roble. All rights reserved.
//

import UIKit
import SnapKit

protocol MovieCollectionViewDelegate: class {
    func movieCellDidTapMoreInfoButton(_ cell: MovieCollectionViewCell)
}

final class MovieCollectionViewCell: UICollectionViewCell {

    fileprivate static let insets = UIEdgeInsets(top: 8, left: 15, bottom: 8, right: 15)
    weak var delegate: MovieCollectionViewDelegate?

    let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .clear
        return imageView
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = NSTextAlignment.left
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()

    let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = NSTextAlignment.left
        label.textColor = UIColor(red:0.75, green:0.75, blue:0.75, alpha:1.00)
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        return label
    }()

    let voteAverageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = NSTextAlignment.left
        label.textColor = UIColor(red:0.75, green:0.75, blue:0.75, alpha:1.00)
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        return label
    }()

    fileprivate lazy var moreInfoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("More info", for: .normal)
        button.layer.cornerRadius = 8
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        button.backgroundColor = UIColor(red:0.85, green:0.21, blue:0.22, alpha:1.00)
        button.addTarget(self, action: #selector(MovieCollectionViewCell.onPressedMoreInfo(_:)), for: .touchUpInside)
        return button
    }()

    let separator: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = UIColor(red: 200 / 255.0, green: 199 / 255.0, blue: 204 / 255.0, alpha: 1).cgColor
        return layer
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeUI()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let bounds = contentView.bounds
        let height: CGFloat = 0.5
        let left = MovieCollectionViewCell.insets.left
        separator.frame = CGRect(x: left, y: bounds.height - height, width: bounds.width - left, height: height)
    }

    func makeUI() {
        let margin = MovieCollectionViewCell.insets.left
        contentView.addSubview(posterImageView)
        posterImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(margin)
            make.leading.equalToSuperview().offset(margin)
            make.bottom.equalToSuperview().inset(margin)
            make.width.equalTo(contentView.frame.height - margin*2)
        }
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(posterImageView.snp.trailing).offset(margin)
            make.top.equalTo(posterImageView.snp.top)
            make.trailing.equalToSuperview().offset(-margin)
        }
        contentView.addSubview(releaseDateLabel)
        releaseDateLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(posterImageView.snp.trailing).offset(margin)
            make.top.equalTo(titleLabel.snp.bottom)
            make.trailing.equalToSuperview().offset(-margin)
            make.height.equalTo(17)
        }
        contentView.addSubview(voteAverageLabel)
        voteAverageLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(posterImageView.snp.trailing).offset(margin)
            make.top.equalTo(releaseDateLabel.snp.bottom)
            make.trailing.equalToSuperview().offset(-margin)
            make.height.equalTo(17)
        }
        contentView.addSubview(moreInfoButton)
        moreInfoButton.snp.makeConstraints { (make) in
            make.leading.equalTo(posterImageView.snp.trailing).offset(margin)
            make.width.equalToSuperview().multipliedBy(0.2)
            make.height.equalTo(35)
            make.bottom.equalTo(posterImageView.snp.bottom)
        }
        contentView.layer.addSublayer(separator)
    }

    @objc func onPressedMoreInfo(_ button: UIButton) {
        delegate?.movieCellDidTapMoreInfoButton(self)
    }
}
