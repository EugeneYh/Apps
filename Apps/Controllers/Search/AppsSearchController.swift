//
//  SearchControllerCollectionViewController.swift
//  Apps
//
//  Created by Eugene on 06.01.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit
import SDWebImage

class AppsSearchController: BaseListController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    let cellId = "searchCellId"
    var searchResults = [Result]()
    var timer: Timer?
    let searchController = UISearchController(searchResultsController: nil)
    
    let searchInviteLabel: UILabel = {
        let label = UILabel()
        label.text = "Type your search text above"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.addSubview(searchInviteLabel)
        searchInviteLabel.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: 100).isActive = true
        searchInviteLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        setupSearchController()
    }
    
    
    
    fileprivate func setupSearchController() {
        definesPresentationContext = true
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
           print(searchText)
        
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            Service.shared.fetchApp(seacrhTerm: searchText) { (result, err) in
                self.searchResults = result?.results ?? []
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        })
    }
    
    fileprivate func fetchSearchData() {
        Service.shared.fetchApp(seacrhTerm: "Twitter") { (result, error) in
            if let error = error {
                print(error)
                return
            }
            self.searchResults = result?.results ?? []
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 350)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchResultCell
        cell.result = searchResults[indexPath.item]
        return cell
    }
}
