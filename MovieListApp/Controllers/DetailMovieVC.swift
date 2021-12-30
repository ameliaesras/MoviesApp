//
//  DetailMovieVC.swift
//  MovieListApp
//
//  Created by Amelia Esra S on 29/12/21.
//

import UIKit
import Alamofire
import SwiftyJSON
import youtube_ios_player_helper

class DetailMovieVC: UIViewController {
    
    var keyVideo:String = ""
    var receiveMovieID:Int = 0
    var receiveOverviewMovie:String = ""
    var receiveVoteAvrg:Float = 0
    var serverAPI = API()
    
    @IBOutlet weak var playerView: YTPlayerView!
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var voteAverage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getVideoTrailerMovie()
        voteAverage.text = String(receiveVoteAvrg)
        overviewTextView.text = receiveOverviewMovie
        overviewTextView.layer.masksToBounds = true
        overviewTextView.layer.cornerRadius = 10
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
    }
    
    func getVideoTrailerMovie(){
        self.showSpinner(onView: self.view)
        let parameter : Parameters = ["api_key": serverAPI.apiKey,
                                      "language": serverAPI.sLanguage
                                     ]
        AF.request("\(serverAPI.baseUrlAPI)movie/\(receiveMovieID)/videos?", method: .get, parameters: parameter).responseJSON { (response) in
            
            switch response.result {
            
            case .success(let value):
                self.removeSpinner()
                let json = JSON(value)
                print("JSON video : \(json)")
                
                if json["id"].stringValue != "" {
                    
                    for i in 0 ..< json["results"].count {
                        
                        let type = json["results"][i]["type"].stringValue
                        let key = json["results"][i]["key"].stringValue
                        
                        if type == "Trailer" {
                            
                            self.playerView.load(withVideoId: key)
                        }
                    }
                }
                
            case .failure(let error):
                self.removeSpinner()
                print("Error get video trailer movie : \(error.localizedDescription)")
            }
        }
    }

}
