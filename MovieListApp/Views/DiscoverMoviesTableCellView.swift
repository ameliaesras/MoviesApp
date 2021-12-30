//
//  DiscoverMoviesTableCellView.swift
//  MovieListApp
//
//  Created by Amelia Esra S on 28/12/21.
//

import UIKit
import Cosmos

class DiscoverMoviesTableCellView: UITableViewCell {
    
    var overviewMovie:String = ""
    var movieID: Int = 0
    var voteAverage: Float = 0
    var currentPage: Int = 0
    var serverAPI = API()
    
    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var lblTitleMovie: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var starRating: CosmosView!
    @IBOutlet weak var lblValueVoteAverage: UILabel!
    
    func getMovies(movieList: MovieList) {
        
        let urlImgPosterPath = URL(string: "\(serverAPI.baseUrlPosterImgPath + movieList.ImagePath)")!
        
        imageMovie.downloaded(from: urlImgPosterPath, contentMode: .scaleAspectFill)
        imageMovie.layer.masksToBounds = false
        imageMovie.layer.cornerRadius = 10
        imageMovie.clipsToBounds = true
        
        lblTitleMovie.text = movieList.TitleMovie
        lblReleaseDate.text = "Release Date: \(movieList.ReleaseDate)"
        currentPage = movieList.CurrentPage
        movieID = movieList.MovieID
        overviewMovie = movieList.Overview
        
        voteAverage = movieList.VoteAverage
        lblValueVoteAverage.text = String(voteAverage)
        starRating.rating = Double(voteAverage)/2.0
        starRating.settings.fillMode = .precise
        starRating.settings.starSize = 30
        starRating.settings.updateOnTouch = false
        roundedView.dropShadow()

    }
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
