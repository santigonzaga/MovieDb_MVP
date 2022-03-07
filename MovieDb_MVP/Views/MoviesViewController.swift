//
//  MoviesViewController.swift
//  MovieDb_MVP
//
//  Created by Santiago del Castillo Gonzaga on 07/03/22.
//

import Foundation

import UIKit

class MoviesViewController: UIViewController, Coordinating {
    
    var coordinator: Coordinator?
    private let presenter = ListMoviesPresenter()
    private var popularMovies = [Movie]()
    private var nowPlayingMovies = [Movie]()
    
    // MARK: - Subviews
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MoviesTableViewCell.self, forCellReuseIdentifier: MoviesTableViewCell.identifier)
        return tableView
    }()
    
    private var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchController.searchBar.placeholder = "Buscar..."
        return searchController
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureSubviews()
        configureConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.getPopularMovies()
    }
    
    // MARK: - Functionalities
    
    private func configureRefresh() {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        self.tableView.refreshControl = refresh
    }

    @objc func handleRefresh() {
        //promotionPresenter.fetchPromotions(withLoadingScreen: false)
    }
    
    private func configureUI() {
        title = "Movies"
        tableView.dataSource = self
        tableView.delegate = self
        presenter.view = self
        navigationItem.searchController = searchController
    }
    
    private func configureSubviews() {
        view.addSubview(tableView)
    }
    
    private func configureConstraints() {
        let tableViewConstraints = [
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(tableViewConstraints)
    }
    
}

extension MoviesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Popular movies"
        } else {
            return "Now playing"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return popularMovies.count
        } else {
            return nowPlayingMovies.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MoviesTableViewCell.identifier, for: indexPath) as? MoviesTableViewCell else {
            fatalError("Unable to deque reusable cell")
        }
        let model = indexPath.section == 0 ? popularMovies[indexPath.row] : nowPlayingMovies[indexPath.row]
        
        let mutableString = NSMutableAttributedString(attachment: NSTextAttachment(image: UIImage(systemName: "star")!))
        mutableString.append(NSAttributedString(string: " \(model.vote_average)"))
        
        let imageURL = URL(string: "https://image.tmdb.org/t/p/w79\(model.poster_path)")
        
        cell.configure(imageURL: imageURL, title: model.title, overview: model.overview ?? "Filme sem descrição", rating: mutableString)
        
        return cell
    }
    
    
}

extension MoviesViewController: ListMoviesPresenterDelegate {
    func fetchedPopularMovies(movies: [Movie]) {
        self.popularMovies = movies
        self.tableView.reloadData()
    }
    
}
