//
//  Service.swift
//  Apps
//
//  Created by Eugene on 07.01.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import Foundation


class Service {
    
    static let shared = Service()
    
    func fetchApp(seacrhTerm: String, completion: @escaping (SearchResult?, Error?) -> ()) {
        print("Start fetching apps")
        let urlString = "https://itunes.apple.com/search?term=\(seacrhTerm)&entity=software"
        fetchGenericJSONData(urlString: urlString, completion: completion)
//        guard let url = URL(string: urlString) else {return}
//
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if let error = error {
//                print(error)
//                completion([], error)
//                return
//            }
//
//            guard let data = data else {return}
//
//            do {
//                let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
//                completion(searchResult.results, nil)
//
//            } catch let jsonError {
//                print("Failed to decode JSON: ", jsonError)
//                completion([], jsonError)
//            }
//
//        }.resume()
    }
    
    func fetchGamesWeLove(completion: @escaping(AppsGroup?, Error?) -> ()) {
        let urlStringGamesWeLove = "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-games-we-love/all/50/explicit.json"
        fetchAppGroups(urlString: urlStringGamesWeLove, completion: completion)
    }
    
    func fetchAppsWeLove(completion: @escaping(AppsGroup?, Error?) -> ()) {
        let urlStringAppsWeLove = "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-apps-we-love/all/50/explicit.json"
        fetchAppGroups(urlString: urlStringAppsWeLove, completion: completion)
    }
    
    func fetchTopFree(completion: @escaping(AppsGroup?, Error?) -> ()) {
        let urlStringTopFree = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-free/all/50/explicit.json"
        fetchAppGroups(urlString: urlStringTopFree, completion: completion)
    }
    
    func fetchSocialApps(completion: @escaping([SocialApps]?, Error?) -> ()) {
        let urlString = "https://api.letsbuildthatapp.com/appstore/social"
        fetchGenericJSONData(urlString: urlString, completion: completion)
      }
    
    // helpers - fetching a different app groups
    
    func fetchAppGroups(urlString: String, completion: @escaping(AppsGroup?, Error?) -> ()) {
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchGenericJSONData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> ()) {
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                print("Failed to fetch games", error)
                return
            }
            guard let data = data else {return}
            do {
                let fetchResult = try JSONDecoder().decode(T.self, from: data)
                completion(fetchResult, nil)
            } catch {
                completion(nil, error)
                print(error)
            }
        }.resume()
    }
    

    
}
