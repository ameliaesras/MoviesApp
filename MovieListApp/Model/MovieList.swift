//
//  MovieList.swift
//  MovieListApp
//
//  Created by Amelia Esra S on 28/12/21.
//

import Foundation
import UIKit

class MovieList {
    
    var CurrentPage:Int
    var ImagePath:String
    var TitleMovie:String
    var ReleaseDate:String
    var VoteAverage:Float
    var MovieID:Int
    var Overview:String
    
    init(CurrentPage:Int, ImagePath:String, TitleMovie:String, ReleaseDate:String, VoteAverage:Float, MovieID:Int,  Overview:String) {

        self.ImagePath = ImagePath
        self.TitleMovie = TitleMovie
        self.ReleaseDate = ReleaseDate
        self.VoteAverage = VoteAverage
        self.CurrentPage = CurrentPage
        self.MovieID = MovieID
        self.Overview = Overview
    }
}
