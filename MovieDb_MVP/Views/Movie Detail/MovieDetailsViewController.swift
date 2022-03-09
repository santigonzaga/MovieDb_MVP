//
//  MovieDetailsViewController.swift
//  MovieDb_MVP
//
//  Created by Santiago del Castillo Gonzaga on 08/03/22.
//

import UIKit
import Kingfisher

class MovieDetailsViewController: UIViewController, Coordinating {
    
    var coordinator: Coordinator?
    var movie: Movie?
    private var presenter = ShowDetailsPresenter()
    private var genres = [Genre]()
    
    // MARK: - Subviews
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.contentMode = .bottom
        return stackView
    }()
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.contentMode = .bottom
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private let genresLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: .thin)
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12, weight: .thin)
        return label
    }()
    
    private let overviewTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
        configureUI()
        configureSubViews()
        configureConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        presenter.getGenresId()
    }
    
    // MARK: - Functionalities
    
    func configureUI() {
        view.backgroundColor = .systemBackground
        title = "Details"
        navigationController?.navigationBar.prefersLargeTitles = false
        
        guard let movie = movie else { return }
        posterImageView.kf.setImage(with: URL(string: "\(Constants.IMAGE_PATH)\(movie.poster_path)"))
        titleLabel.text = movie.title
        
        let mutableString = NSMutableAttributedString(attachment: NSTextAttachment(image: UIImage(systemName: "star")!))
        mutableString.append(NSAttributedString(string: " \(movie.vote_average)"))
        ratingLabel.attributedText = mutableString
        
        overviewTitleLabel.text = "Overview"
        overviewLabel.text = movie.overview

    }
    
    func configureSubViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(horizontalStackView)
        contentView.addSubview(overviewTitleLabel)
        contentView.addSubview(overviewLabel)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(genresLabel)
        stackView.addArrangedSubview(ratingLabel)
        horizontalStackView.addArrangedSubview(posterImageView)
        horizontalStackView.addArrangedSubview(stackView)
    }
    
    func configureConstraints() {
        let scrollViewConstraints = [
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        let contentViewConstraints = [
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
        ]
        
        let horizontalStackConstraints = [
            horizontalStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18),
            horizontalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            horizontalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)
        ]
        
        let imageViewConstraints = [
            posterImageView.heightAnchor.constraint(equalToConstant: 194),
            posterImageView.widthAnchor.constraint(equalToConstant: 128)
        ]
        
        let overviewTitleConstraints = [
            overviewTitleLabel.topAnchor.constraint(equalTo: horizontalStackView.bottomAnchor, constant: 18),
            overviewTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)
        ]
        
        let overviewConstraints = [
            overviewLabel.topAnchor.constraint(equalTo: overviewTitleLabel.bottomAnchor, constant: 13),
            overviewLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            overviewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            overviewLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ]
        
        NSLayoutConstraint.activate(scrollViewConstraints)
        NSLayoutConstraint.activate(contentViewConstraints)
        NSLayoutConstraint.activate(horizontalStackConstraints)
        NSLayoutConstraint.activate(imageViewConstraints)
        NSLayoutConstraint.activate(overviewTitleConstraints)
        NSLayoutConstraint.activate(overviewConstraints)
    }
}

extension MovieDetailsViewController: ShowDetailsPresenterDelegate {
    func fetchedGenres(genres: [Genre]) {
        guard let movie = movie else { return }
        self.genres = genres.filter({ genre in
            return movie.genre_ids.contains(genre.id)
        })

        DispatchQueue.main.async {
            let genresNames = self.genres.map { genre in
                return genre.name
            }
            self.genresLabel.text = genresNames.joined(separator: ", ")
        }
    }
}
