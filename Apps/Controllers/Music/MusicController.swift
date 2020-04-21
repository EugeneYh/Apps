//
//  MusicController.swift
//  Apps
//
//  Created by Eugene on 20.04.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit

class MusicController: BaseListController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    let footerId = "footerId"
    var trackResult = [Result]()
    let searchTerm = "Solomun"
    var offset = 0
    var queryLimit = 20
    var isPaginating = false
    var donePaginating = false
     
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(TrackViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(TrackViewCellFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerId)
        
        fetchData()
    }
    
    fileprivate func fetchData() {
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&offset=\(offset)&limit=\(queryLimit)"
        
        Service.shared.fetchGenericJSONData(urlString: urlString) { (searchResult: SearchResult?, error) in
            if let error = error {
                print(error)
                return
            }
            
            guard let result = searchResult else {return}
            print(result)
            self.trackResult = result.results
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trackResult.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerId, for: indexPath)
        if donePaginating {
            footer.isHidden = true
        }
        return footer
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let height: CGFloat = donePaginating ? 0 : 100
        return .init(width: view.frame.width, height: height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TrackViewCell
        let track = trackResult[indexPath.item]
        cell.titleLabel.text = track.trackName
        cell.trackInfoLabel.text = "\(track.artistName ?? "")•\(track.collectionName ?? "")•\(track.primaryGenreName)"
        cell.imageView.sd_setImage(with: URL(string: track.artworkUrl100))
        
        if indexPath.item == trackResult.count - 1 && !isPaginating{
            isPaginating = true
            offset = trackResult.count
            
            let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&offset=\(offset)&limit=\(queryLimit)"
            
            Service.shared.fetchGenericJSONData(urlString: urlString) { (searchResult: SearchResult?, error) in
                if let error = error {
                    print(error)
                    self.donePaginating = true
                    return
                }
                
//                if searchResult?.results.count == 0 {
//                    self.donePaginating = true
//                }
                
                guard let result = searchResult else {return}

                self.trackResult += result.results
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                self.isPaginating = false
            }
            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 100)
    }
    
    
    
}
