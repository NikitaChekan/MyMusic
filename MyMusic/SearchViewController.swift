//
//  SearchViewController.swift
//  MyMusic
//
//  Created by jopootrivatel on 20.03.2023.
//

import UIKit
import Alamofire

struct TrackModel {
    var trackName: String
    var artistName: String
    
}

class SearchViewController: UITableViewController {
    
    var networkService = NetworkService()
    
    private var timer: Timer?
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var trackList = [Track]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        
        setupSearchBar()
        
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trackList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        
        let track = trackList[indexPath.row]
        cell.textLabel?.numberOfLines = 2
        cell.textLabel?.text = "\(track.trackName)\n\(track.artistName)"
        cell.imageView?.image = UIImage(named: "track")
        
        return cell
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.networkService.fetchTracks(searchText: searchText) { [weak self] (searchResults) in
                self?.trackList = searchResults?.results ?? []
                self?.tableView.reloadData()
            }
            
        })
    }
}
