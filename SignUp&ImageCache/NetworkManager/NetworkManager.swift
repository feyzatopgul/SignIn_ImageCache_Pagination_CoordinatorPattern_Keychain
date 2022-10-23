//
//  NetworkManager.swift
//  SignUp&ImageCache
//
//  Created by fyz on 6/16/22.
//
// https://api.unsplash.com/search/photos?&page=1&client_id=lfWuwUy1arCjnKJSAyEW1ryaRpJG5X7va_ERdsg_l7w&query=puppy

import Foundation
protocol NetworkManagerProtocol {
    func fetchData(page:Int, completion:@escaping ([Model]?, Error?) -> Void)
    func fetchImage(model: Model, completion:@escaping (Data?, Error?) -> Void)
}

enum NetworkManagerError: Error {
    case badResponse(URLResponse?)
    case badData
    case badLocalUrl
}
class NetworkManager: NetworkManagerProtocol {
    
    static var shared = NetworkManager()
    private init(){}
    private let accessKey = "YOUR_KEY"
    private let searchTerm = "puppy"
    private var images = NSCache<NSString, NSData>()
    
    
    func fetchData(page:Int, completion:@escaping ([Model]?, Error?) -> Void) {
        let urlString = "https://api.unsplash.com/search/photos?&page=\(String(page))&client_id=\(accessKey)&query=\(searchTerm)"
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(nil, NetworkManagerError.badResponse(response))
                return
            }
            guard let data = data else {
                completion(nil, NetworkManagerError.badData)
                return
            }

            do {
                let apiResponse = try JSONDecoder().decode(APIResponse.self, from: data)
                completion(apiResponse.results, nil)
                } catch let error {
                    completion(nil, error)
                }
        }
        task.resume()
    }
    func fetchImage(model: Model, completion:@escaping (Data?, Error?) -> Void) {
        let url = URL(string: model.urls.thumb)
        if let imageData = images.object(forKey: url!.absoluteString as NSString) {
            print("Using cached images")
            completion(imageData as Data, nil)
            return
        }
        let task = URLSession.shared.downloadTask(with: url!) { localUrl, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(nil, NetworkManagerError.badResponse(response))
                return
            }
            guard let localUrl = localUrl else {
                completion(nil, NetworkManagerError.badLocalUrl)
                return
            }
            do {
                let data = try Data(contentsOf: localUrl)
                self.images.setObject(data as NSData, forKey: url!.absoluteString as NSString)
                completion(data, nil)
            } catch let error {
                completion(nil, error)
            }
        }
        task.resume()
    }
}


