//
//  MoviesTvsShowCollectionViewController.swift
//  ExamenRappi
//
//  Created by Juan Arcos on 10/19/19.
//  Copyright © 2019 Arcos. All rights reserved.
//

import Foundation
import UIKit

class MoviesTvsShowCollectionViewController: UICollectionViewController {
    
    lazy var settingViewModel: SettingsViewModel = {
        return SettingsViewModel()
    }()
    
    lazy var contentData: [ResultMovieModel] = {
        return [ResultMovieModel]()
    }()
    
    public var customCollectionViewLayout: UICustomCollectionViewLayout? {
        get {
            return collectionViewLayout as? UICustomCollectionViewLayout
        }
        set {
            if newValue != nil {
                collectionView.collectionViewLayout = newValue!
            }
        }
    }
    
    //MARK: UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movies"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        collectionView.register(UINib.init(nibName: "MoviesTvsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "previewCell")
        self.customCollectionViewLayout?.delegate = self
        self.customCollectionViewLayout?.numberOfColumns = 2
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //Reload collection data
        getMoviesByType()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueMovieDetail" {
            guard let nav = segue.destination as? UINavigationController,
                let movieDetailVC = nav.viewControllers.first as?  MovieDetailViewController,
                let model = sender as? ResultMovieModel else {
                    return
            }
            
            movieDetailVC.movieModel = model
            
        }
    }
    
    private func getMoviesByType() {
        ActivityIndicator.showLoader()
        ServicesManager.getMoviesByType(settingViewModel.selectedCategory) { result in
            ActivityIndicator.hiddenLoader(nil, closure: { (_) in })
            switch result {
            case .success:
                print("success")
                //self.performSegue(withIdentifier: "segueListMovies", sender: typeMovie)
                self.getContentData()
            case .failure(let message):
                print("failure: \(message)")
            //self.validateMovieLocalData(typeMovie: typeMovie)
            case .failureData(let errorModel):
                print("failureData: \(String(describing: errorModel.errorcode))")
                //self.showToastMessage(message: Constants.GlobalMessage.Error.errorMessage, type: .warning, slideFrom: .top)
            }
        }
    }
    
    private func validateMovieLocalData(category: Category){
        let data = DataSourceManager.getMoviesByType(category: category)
        if data.count > 0 {
            //self.performSegue(withIdentifier: "segueListMovies", sender: typeMovie)
        }else {
            //self.showToastMessage(message: Constants.GlobalMessage.Error.errorAvailable, type: .warning, slideFrom: .top)
        }
    }
    
    private func getContentData() {
        self.contentData = DataSourceManager.getMoviesByType(category: settingViewModel.selectedCategory)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contentData.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = self.contentData[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "previewCell", for: indexPath) as! MoviesTvsCollectionViewCell
        cell.imageView.getImageWithUrl(url: "\(Constants.UrlServices.ImagePath)\(model.poster_path ?? "")", cache: true)
        return cell
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = self.contentData[indexPath.row]
        performSegue(withIdentifier: "segueMovieDetail", sender: model)
    }
}

//MARK: CustomLayoutDelegate

extension MoviesTvsShowCollectionViewController: CustomLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        heightForItemAt
        indexPath: IndexPath,
                        with width: CGFloat) -> CGFloat {
        let heightSizes = [100,216]
        let number = Int.random(in: 0 ..< 10)
        return CGFloat(heightSizes[number % 2 == 0 ? 1 : 0])
    }
}