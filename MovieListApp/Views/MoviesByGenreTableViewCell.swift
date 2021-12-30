//
//  MoviesByGenreTableViewCell.swift
//  MovieListApp
//
//  Created by Amelia Esra S on 28/12/21.
//

import UIKit


class MoviesByGenreCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var releaseDateMovie: UILabel!
    @IBOutlet weak var roundedView: UIView!
    

    func getListMovieByGenre(movieLists: MovieList){
   
        let urlImage = URL(fileURLWithPath: movieLists.imagePath)
        
        guard let imageData = try? Data(contentsOf: urlImage) else {return}

        let imgMovie = UIImage(data: imageData)

        roundedView.dropShadow()
        imageMovie.image = imgMovie
        titleMovie.text = movieLists.TitleMovie
        releaseDateMovie.text = movieLists.ReleaseDate
       
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


}
