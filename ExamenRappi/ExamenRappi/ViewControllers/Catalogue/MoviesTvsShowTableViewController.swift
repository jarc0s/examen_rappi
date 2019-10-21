//
//  MoviesTvsShowTableViewController.swift
//  ExamenRappi
//
//  Created by Juan Arcos on 10/19/19.
//  Copyright © 2019 Arcos. All rights reserved.
//

import Foundation
import UIKit


class MoviesTvsShowTableViewController: UITableViewController {
     
     lazy var settingViewModel: SettingsViewModel = {
          return SettingsViewModel()
     }()
     
     lazy var contentData: [ResultMovieModel] = {
          return [ResultMovieModel]()
     }()
     
     
     //MARK: UIViewController
     override func viewDidLoad() {
          super.viewDidLoad()
          self.title = "Movies"
          self.navigationController?.navigationBar.prefersLargeTitles = true
          tableView.register(UINib.init(nibName: "MoviesTvsTableViewCell", bundle: nil), forCellReuseIdentifier: "previewCell")
          tableView.estimatedRowHeight = 500.0
          tableView.rowHeight = UITableView.automaticDimension
          
     }
     
     override func viewDidAppear(_ animated: Bool) {
          super.viewDidAppear(animated)
          //Reload table view controller
          getMoviesByType()
     }
     
     override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          
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
               self.tableView.reloadData()
          }
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
}


extension MoviesTvsShowTableViewController {
     //MARK: UITableViewCell
     override func numberOfSections(in tableView: UITableView) -> Int {
          return 1
     }
     
     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return self.contentData.count
     }
     
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          
          let model = self.contentData[indexPath.row]
          let cell = tableView.dequeueReusableCell(withIdentifier: "previewCell", for: indexPath) as! MoviesTvsTableViewCell
          cell.selectionStyle = .none
          cell.labelTitle.text = model.original_title ?? ""
          cell.labelOverview.text = model.overview ?? ""
          cell.labelReleaseDate.text = model.release_date ?? ""
          cell.imagePosterView.getImageWithUrl(url: "\(Constants.UrlServices.ImagePath)\(model.poster_path ?? "")", cache: true)
          return cell
     }
     
     
     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          let model = self.contentData[indexPath.row]
          performSegue(withIdentifier: "segueMovieDetail", sender: model)
     }
     
}
