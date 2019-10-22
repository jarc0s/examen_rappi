//
//  MoviesTvsShowTableViewController.swift
//  ExamenRappi
//
//  Created by Juan Arcos on 10/19/19.
//  Copyright © 2019 Arcos. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class MoviesTvsShowTableViewController: UITableViewController {
     
     lazy var settingViewModel: SettingsViewModel = {
          return SettingsViewModel()
     }()
     
     lazy var contentData: [ResultMovieModel] = {
          return [ResultMovieModel]()
     }()
     
     lazy var fetchingMore: Bool = {
          return false
     }()
     
     var disposeBag = DisposeBag()
     
     //MARK: UIViewController
     override func viewDidLoad() {
          super.viewDidLoad()
          self.navigationController?.navigationBar.prefersLargeTitles = true
          tableView.register(UINib.init(nibName: "MoviesTvsTableViewCell", bundle: nil), forCellReuseIdentifier: "previewCell")
          tableView.estimatedRowHeight = 500.0
          tableView.rowHeight = UITableView.automaticDimension
          registerForPreviewing(with: self, sourceView: self.tableView)
          getMoviesByType()
     }
     
     override func viewDidAppear(_ animated: Bool) {
          super.viewDidAppear(animated)
          self.title = settingViewModel.selectedCategory.rawValue.capitalized
     }
     
     override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          
     }
     
     private func getMoviesByType() {
          
          if settingViewModel.isInTheRange {
               ActivityIndicator.showLoader()
               ServicesManager.getMoviesByType(settingViewModel.selectedCategory, page: settingViewModel.currentPage) { result in
                    ActivityIndicator.hiddenLoader(nil, closure: { (_) in })
                    switch result {
                    case .success:
                         print("success")
                         self.getContentData()
                    case .failure(let message):
                         print("failure: \(message)")
                         self.validateMovieLocalData(category: self.settingViewModel.selectedCategory)
                    case .failureData(let errorModel):
                         print("failureData: \(String(describing: errorModel.errorcode))")
                         ShowMessage.showToastMessage(message: Constants.GlobalMessage.Error.errorMessage, type: .warning, slideFrom: .top)
                    }
               }
          }
     }
     
     private func validateMovieLocalData(category: Category){
          let data = DataSourceManager.getMoviesByType(category: category)
          if data.count > 0 {
               self.contentData = data
               DispatchQueue.main.async {
                    self.tableView.reloadData()
               }
          }else {
               ShowMessage.showToastMessage(message: Constants.GlobalMessage.Error.errorAvailable, type: .warning, slideFrom: .top)
          }
     }
     
     private func getContentData() {
          self.contentData = DataSourceManager.getMoviesByType(category: settingViewModel.selectedCategory)
          DispatchQueue.main.async {
               self.fetchingMore = false
//               self.firtsTime = false
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
          } else if segue.identifier == "segueSettings" {
               guard let nav = segue.destination as? UINavigationController,
                    let settingsVC = nav.viewControllers.first as?  SettingsViewController else {
                         return
               }
               settingsVC.selectedCategory.subscribe(onNext: { [weak self] category in
                    self?.getMoviesByType()
               }).disposed(by: self.disposeBag)
          }
     }
     
     override func scrollViewDidScroll(_ scrollView: UIScrollView) {
          let offsetY = scrollView.contentOffset.y
          let contentHeight = scrollView.contentSize.height
          if offsetY > contentHeight - scrollView.frame.height {
               if !fetchingMore {
                    beginingBatchFetch()
               }
          }
     }
     
     func beginingBatchFetch() {
          fetchingMore = true
          self.getMoviesByType()
     }
     
     func createDetailViewControllerIndexPath(indexPath: IndexPath) -> UIViewController{
          
          
          let storyboard = UIStoryboard(name: "Main", bundle: nil)
          
          guard let vc = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController else {
               fatalError("Couldn't load detail view controller")
          }
          
          vc.movieModel = contentData[indexPath.row]
          vc.isModalPresenter = true
          return vc
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
     
     override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
          let animation = AnimationFactory.makeSlideIn(duration: 0.2, delayFactor: 0.02)
          let animator = Animator(animation: animation)
          animator.animate(cell: cell, at: indexPath, in: tableView)
     }
}

extension MoviesTvsShowTableViewController : UIViewControllerPreviewingDelegate {
     func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
          guard let indexPath = tableView.indexPathForRow(at: location) else {
               return nil
          }
          
          let detailViewController = createDetailViewControllerIndexPath(indexPath: indexPath)
          
          return detailViewController
     }
     
     func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
          navigationController?.pushViewController(viewControllerToCommit, animated: true)
     }
     
}
