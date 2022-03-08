//
//  MoviesViewController.swift
//  MovieDb_MVP
//
//  Created by Santiago del Castillo Gonzaga on 07/03/22.
//

import UIKit

class MoviesViewController: UIViewController, Coordinating {
    
    var coordinator: Coordinator?
    private let presenter = ListMoviesPresenter()
    private var popularMovies = [Movie]()
    private var popularMoviesFiltered = [Movie]()
    private var nowPlayingMovies = [Movie]()
    private var nowPlayingMoviesFiltered = [Movie]()
    
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
        configureRefresh()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.getPopularMovies()
        presenter.getNowPlayingMovies()
    }
    
    // MARK: - Functionalities
    
    private func configureRefresh() {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        self.tableView.refreshControl = refresh
    }

    @objc func handleRefresh() {
        presenter.getPopularMovies(isRefreshing: true)
        presenter.getNowPlayingMovies()
    }
    
    private func configureUI() {
        title = "Movies"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.dataSource = self
        tableView.delegate = self
        presenter.view = self
        searchController.searchBar.delegate = self
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
            return popularMoviesFiltered.count
        } else {
            return nowPlayingMoviesFiltered.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MoviesTableViewCell.identifier, for: indexPath) as? MoviesTableViewCell else {
            fatalError("Unable to deque reusable cell")
        }
        let model = indexPath.section == 0 ? popularMoviesFiltered[indexPath.row] : nowPlayingMoviesFiltered[indexPath.row]
        
        let mutableString = NSMutableAttributedString(attachment: NSTextAttachment(image: UIImage(systemName: "star")!))
        mutableString.append(NSAttributedString(string: " \(model.vote_average)"))
        
        let imageURL = URL(string: "\(Constants.IMAGE_PATH)\(model.poster_path)")

        cell.configure(imageURL: imageURL, title: model.title, overview: model.overview, rating: mutableString)
        
        return cell
    }
    
}

extension MoviesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        nowPlayingMoviesFiltered = nowPlayingMovies
        popularMoviesFiltered = popularMovies
        
        if !searchText.isEmpty {
            nowPlayingMoviesFiltered = nowPlayingMovies.filter{ $0.title.lowercased().contains(searchText.lowercased())}
            popularMoviesFiltered = popularMovies.filter{ $0.title.lowercased().contains(searchText.lowercased())}
        }
        
        self.tableView.reloadData()
    }
}

extension MoviesViewController: ListMoviesPresenterDelegate {
    func fetchedPopularMovies(movies: [Movie]) {
        self.popularMoviesFiltered = movies
        self.popularMovies = movies
        self.tableView.reloadData()
        self.tableView.refreshControl?.endRefreshing()
    }
    
    func fetchedNowPlayingMovies(movies: [Movie]) {
        self.nowPlayingMoviesFiltered = movies
        self.nowPlayingMovies = movies
        self.tableView.reloadData()
        self.tableView.refreshControl?.endRefreshing()
    }
    
}
