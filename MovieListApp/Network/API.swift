//
//  API.swift
//  MovieListApp
//
//  Created by Amelia Esra S on 28/12/21.
//

import Foundation

class API {
   
    let apiKey = "7c21c814ec56fac3758592a439a3335c"
    let baseUrlAPI = "https://api.themoviedb.org/3/"
    let baseUrlPosterImgPath = "https://image.tmdb.org/t/p/w500"
    let sLanguage = "en-US"
    let sSortBy = "popularity.desc"
    let getGenreMovieURL = "genre/movie/list?"
    let getDiscoverMoviesByGenre = "discover/movie?"
}
