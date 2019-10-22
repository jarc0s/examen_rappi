//
//  SettingsViewController.swift
//  ExamenRappi
//
//  Created by Juan Arcos on 10/19/19.
//  Copyright © 2019 Arcos. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class SettingsViewController: UITableViewController {
    
    private var settingsViewModel = SettingsViewModel()
    
    private let selectedCategorySubject = PublishSubject<Category>()
    var selectedCategory: Observable<Category> {
        return selectedCategorySubject.asObservable()
    }
    
    @IBAction func closeView(_ sender: UIBarButtonItem) {
        self.selectedCategorySubject.onNext(settingsViewModel.selectedCategory)
        self.dismiss(animated: true, completion: nil)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.settingsViewModel.categories.count - 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let settingsItem = self.settingsViewModel.categories[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath)
        
        cell.textLabel?.text = settingsItem.displayName
        
        if settingsItem == self.settingsViewModel.selectedCategory {
            cell.accessoryType = .checkmark
        }
        
        return cell
        
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.visibleCells.forEach{ cell in
            cell.accessoryType = .none
        }
        
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
            let category = Category.allCases[indexPath.row]
            self.settingsViewModel.selectedCategory = category
            self.settingsViewModel.currentPage = 1
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath){
            cell.accessoryType = .none
        }
    }
    
    
    
    
}
