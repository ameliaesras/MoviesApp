//
//  ViewController.swift
//  MovieListApp
//
//  Created by Amelia Esra S on 27/12/21.
//

import UIKit
import Alamofire
import SwiftyJSON

class GenreController: UIViewController {

    var genreId:Int = 0
    var serverAPI = API()
    var genreModel = [GenreMovie]()
    
    @IBOutlet weak var genreMovieCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        genreMovieCollectionView.delegate = self
        genreMovieCollectionView.dataSource = self
        getGenreMovie()
        
    }
    
    //MARK: Get Genre Movie from API
    func getGenreMovie() {
        self.showSpinner(onView: self.view)
        let parameter : Parameters = ["api_key": serverAPI.apiKey,
                                      "language": serverAPI.sLanguage
                                     ]
        
        AF.request(serverAPI.baseUrlAPI + serverAPI.getGenreMovieURL, method: .get, parameters: parameter).responseJSON { (response) in
            
            switch response.result {
            
            case .success(let value):
                self.removeSpinner()
                let json = JSON(value)
              
                for i in 0 ..< json["genres"].count {
                    
                    let nameGenre = json["genres"][i]["name"].stringValue
                    let idGenre = json["genres"][i]["id"].int
                    
                    self.genreModel.append(GenreMovie(genreString: nameGenre, idGenre: idGenre ?? 0))
                }
                break
                
            case .failure(let error):
                self.removeSpinner()
                print("Error get Genre Movie : \(error.localizedDescription)")
                break
            }
            self.genreMovieCollectionView.reloadData()
        }
    }
}

extension GenreController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
            let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
            let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
            let size:CGFloat = (genreMovieCollectionView.frame.size.width - space) / 2.0
            return CGSize(width: size, height: size)
        }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return genreModel.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let dataModel = genreModel[indexPath.item]

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenreCollectionViewCell", for: indexPath) as! GenreCollectionViewCell

        cell.getGenreMovies(genreMovie: dataModel)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath)
        genreId = genreModel[indexPath.item].idGenre
        
        if cell?.isSelected == true {
            
            let displayDiscoverMoviesVC = storyboard?.instantiateViewController(withIdentifier: "DiscoverMoviesController") as! DiscoverMoviesController
            displayDiscoverMoviesVC.receiveIdGenre = genreId
            
            navigationController?.pushViewController(displayDiscoverMoviesVC, animated: true)
            
        }
    }
}

