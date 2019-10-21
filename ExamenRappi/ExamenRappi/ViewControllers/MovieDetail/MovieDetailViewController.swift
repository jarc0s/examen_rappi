//
//  MovieDetailViewController.swift
//  ExamenRappi
//
//  Created by Juan Arcos on 10/20/19.
//  Copyright © 2019 Arcos. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage
import YoutubePlayer_in_WKWebView

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelNumberVotes: UILabel!
    @IBOutlet weak var labelVoteAverage: UILabel!
    @IBOutlet weak var labelOverview: UILabel!
    @IBOutlet weak var playerView: WKYTPlayerView!
    
    lazy var settingViewModel: SettingsViewModel = {
        return SettingsViewModel()
    }()
    
    lazy var movieModel: ResultMovieModel = {
        return ResultMovieModel()
    }()
    
    @IBAction func closeView(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        viewConfiguration()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.getMovieDetail()
    }
    
    
    private func viewConfiguration() {
        self.imageMovie.getImageWithUrl(url: "\(Constants.UrlServices.ImagePath)\(movieModel.backdrop_path ?? "")", cache: true)
        self.labelTitle.text = movieModel.original_title
        self.labelNumberVotes.text = "\(movieModel.vote_count ?? 0) votes"
        self.labelVoteAverage.text = "Vote average: \(movieModel.vote_average ?? 0)"
        self.labelOverview.text = movieModel.overview ?? ""
        
        //self.imageBackGround.getImageWithUrl(url: "\(Constants.UrlServices.ImagePath)\(movieModel.poster_path ?? "")", cache: true, applyMaskColor: ColorPallete.rgb_595d9f.asColor(withAlpha: 1.0))
    }
    
    private func getMovieDetail(){
        ServicesManager.getMovieById("\(movieModel.id ?? 0)", category: .videos) { (result) in
            switch result {
            case .success:
                print("Show Video")
                self.loadVideo(id: "\( self.movieModel.id ?? 0)")
            case .failure( _):
                print("Hide Video")
            case .failureData( _):
                print("Hide Video")
            }
        }
    }
    
    private func loadVideo(id : String){
        
        var youtubeId = ""
        
        youtubeId = DataSourceManager.getVideoTrailerIdByMovieId(id: id, category: .videos)
        
        if !youtubeId.isEmpty {
            playerView.isHidden = false
            playerView.load(withVideoId: youtubeId)
            playerView.delegate = self
        }
    }
}

extension MovieDetailViewController : WKYTPlayerViewDelegate {
    func playerView(_ playerView: WKYTPlayerView, receivedError error: WKYTPlayerError) {
        print("Error")
    }
}
