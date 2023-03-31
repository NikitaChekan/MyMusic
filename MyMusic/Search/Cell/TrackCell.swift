//
//  TrackCell.swift
//  MyMusic
//
//  Created by jopootrivatel on 22.03.2023.
//

import UIKit
import SDWebImage

protocol TrackCellViewModel {
    var iconUrlString: String? { get }
    var trackName: String { get }
    var artistName: String { get }
    var collectionName: String { get }

}

class TrackCell: UITableViewCell {
    
    @IBOutlet var trackImageView: UIImageView!
    @IBOutlet var trackNameLabel: UILabel!
    @IBOutlet var artistNameLabel: UILabel!
    @IBOutlet var collectionNameLabel: UILabel!
    
    static let reuseId = "TrackCell"
    
    var cell: SearchViewModel.Cell?
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        trackImageView.image = nil
    }
    
    @IBAction func addTrackAction(_ sender: Any) {
        let defaults = UserDefaults.standard
        
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: cell, requiringSecureCoding: false) {
            defaults.set(savedData, forKey: "tracks")
        }
    }
    
    func set(viewModel: SearchViewModel.Cell) {
        self.cell = viewModel
        
        trackNameLabel.text = viewModel.trackName
        artistNameLabel.text = viewModel.artistName
        collectionNameLabel.text = viewModel.collectionName
        
        guard let url = URL(string: viewModel.iconUrlString ?? "") else { return }
        trackImageView.sd_setImage(with: url, completed: nil)
    }
    
}
