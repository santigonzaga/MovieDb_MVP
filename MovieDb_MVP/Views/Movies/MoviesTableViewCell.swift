//
//  MoviesTableViewCell.swift
//  MovieDb_MVP
//
//  Created by Pedro Gomes Rubbo Pacheco on 07/03/22.
//

import UIKit
import Kingfisher

class MoviesTableViewCell: UITableViewCell {
    
    static let identifier = "MoviesTableViewCellIdentifier"

    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 4
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .thin)
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        //stackView.distribution = .equalCentering
        return stackView
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        contentView.subviews.forEach { $0.removeFromSuperview() }
        contentView.constraints.forEach { contentView.removeConstraint($0) }
    }
    
    func configure(imageURL: URL?, title: String, overview: String, rating: NSMutableAttributedString) {
        configureSubviews()
        configureConstraints()
        posterImageView.kf.setImage(with: imageURL)
        titleLabel.text = title
        overviewLabel.text = overview
        ratingLabel.attributedText = rating
    }
    
    private func configureSubviews() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(overviewLabel)
        stackView.addArrangedSubview(ratingLabel)
    }
    
    private func configureConstraints() {
        let constraint = posterImageView.heightAnchor.constraint(equalToConstant: 118)
        constraint.priority = UILayoutPriority(750)
        constraint.isActive = true
        
        let imageViewConstraints = [
            //posterImageView.heightAnchor.constraint(equalToConstant: 118),
            posterImageView.widthAnchor.constraint(equalToConstant: 79),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ]
        
        let stackViewConstraints = [
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            stackView.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 10),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ]
        
        NSLayoutConstraint.activate(imageViewConstraints)
        NSLayoutConstraint.activate(stackViewConstraints)
    }

}
