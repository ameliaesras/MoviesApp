//
//  GenreCollectionViewCell.swift
//  MovieListApp
//
//  Created by Amelia Esra S on 28/12/21.
//

import UIKit
import Foundation

class GenreCollectionViewCell: UICollectionViewCell {
    
    var genreID:Int = 0
    
    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var lblGenreMovie: UILabel!
    
    func getGenreMovies(genreMovie: GenreMovie){
        
        roundedView.dropShadow()
        lblGenreMovie.text = genreMovie.genreString
        genreID = genreMovie.idGenre
    }
}
