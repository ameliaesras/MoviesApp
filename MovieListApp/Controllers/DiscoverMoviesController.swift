//
//  DiscoverMoviesController.swift
//  MovieListApp
//
//  Created by Amelia Esra S on 28/12/21.
//

import UIKit
import Alamofire
import SwiftyJSON
import PaginatedTableView

class DiscoverMoviesController: UIViewController {
    
    var movieID: Int = 0
    var overviewMovie:String = ""
    var currentPage : Int = 0
    var receiveIdGenre:Int = 0
    var voteAverage:Float = 0
    var serverAPI = API()
    var movieList = [MovieList]()
    var isLoadingList : Bool = false
    
    @IBOutlet weak var tableViewMovie: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewMovie.delegate = self
        tableViewMovie.dataSource = self
        getListMovieByGenre()
    }
    
    //MARK: GET MOVIE LIST FROM API
    func getListMovieByGenre(){
        self.showSpinner(onView: self.view)
        print("receiveGenre: \(receiveIdGenre)")
        let parameter : Parameters = ["api_key": serverAPI.apiKey,
                                      "with_genres": receiveIdGenre
                                     ]
        
        AF.request(serverAPI.baseUrlAPI + serverAPI.getDiscoverMoviesByGenre, method: .get, parameters: parameter).responseJSON { (response) in
            
            switch response.result {
            
            case .success(let value):
                self.removeSpinner()
                let json = JSON(value)
                let pageListMovie = json["page"].int
               
                if pageListMovie != 0 {
                    
                    for i in 0 ..< json["results"].count {
                        
                        let poster_path = json["results"][i]["poster_path"].stringValue
                        let title = json["results"][i]["title"].stringValue
                        let releaseDate = json["results"][i]["release_date"].stringValue
                        let voteAverageMovie = json["results"][i]["vote_average"].stringValue
                        let movieID = json["results"][i]["id"].int
                        let overviewMovie = json["results"][i]["overview"].stringValue
                        
                        self.movieList.append(MovieList(CurrentPage: self.currentPage, ImagePath: poster_path, TitleMovie: title, ReleaseDate: releaseDate, VoteAverage: Float(voteAverageMovie) ?? 0, MovieID: movieID ?? 0, Overview: overviewMovie))
                        
                    }
                  
                }
                
                self.currentPage = Int(pageListMovie ?? 0)
                
                break
            case .failure(let error):
                self.removeSpinner()
                print("Error get movie list by genre : \(error.localizedDescription)")
                break
            }
            
            self.tableViewMovie.reloadData()
        }
    }
    
    func getListFromServer(_ pageNumber: Int){
        self.isLoadingList = false
        self.tableViewMovie.reloadData()
    }
    
    func loadMoreItemsForList(){
        currentPage += 1
        getListFromServer(currentPage)
    }

}

extension DiscoverMoviesController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let data = movieList[indexPath.item]

        let cell = tableView.dequeueReusableCell(withIdentifier: "DiscoverMoviesTableCellView") as! DiscoverMoviesTableCellView

        cell.getMovies(movieList: data)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        movieID = movieList[indexPath.row].MovieID
        overviewMovie = movieList[indexPath.row].Overview
        voteAverage = Float(movieList[indexPath.row].VoteAverage)
        
        if cell?.isSelected == true {
            
            let displayDetailMovieVC = storyboard?.instantiateViewController(withIdentifier: "DetailMovieVC") as! DetailMovieVC
            displayDetailMovieVC.receiveMovieID = movieID
            displayDetailMovieVC.receiveOverviewMovie = overviewMovie
            displayDetailMovieVC.receiveVoteAvrg = voteAverage
            navigationController?.pushViewController(displayDetailMovieVC, animated: true)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if (((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height ) && !isLoadingList){
          
            self.isLoadingList = true
            self.loadMoreItemsForList()
       }
    }
    
}
