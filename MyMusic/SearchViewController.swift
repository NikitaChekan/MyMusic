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
    
    let searchController = UISearchController(searchResultsController: nil)
    
    let trackList = [
        TrackModel(trackName: "Sex in ass", artistName: "Nick Chekan"),
        TrackModel(trackName: "18+", artistName: "Nick Chekan")
    ]
    
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
        
        let url = "https://itunes.apple.com/search?term=\(searchText)"
        
        AF.request(url).responseData { (dataResponse) in
            if let error = dataResponse.error {
                print("Error received requesting data: \(error.localizedDescription)")
                return
            }
            
            guard let data = dataResponse.data else { return }
            let someString = String(data: data, encoding: .utf8)
            print(someString ?? "")
        }

    }
    
}
