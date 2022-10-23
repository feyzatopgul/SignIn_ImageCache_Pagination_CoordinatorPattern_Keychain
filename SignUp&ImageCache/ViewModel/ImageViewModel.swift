//
//  ImageViewModel.swift
//  SignUp&ImageCache
//
//  Created by fyz on 6/16/22.
//

import Foundation


class ImageViewModel {
    
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    func modelData(page:Int, completion: @escaping (_ results: [Model]?,_ error: Error?)-> Void){
        networkManager.fetchData(page: page ) { data, error in
            if let error = error {
                completion(nil, error)
            }
            if let data = data {
                completion(data, nil)
            }
        }
    }
    
    
    func imageData(model: Model, completion: @escaping (_ imageData: Data?, _ error: Error?)->Void) {
        networkManager.fetchImage(model: model ) { data, error in
            if let error = error {
                completion(nil, error)
            }
            if let data = data {
                completion(data, nil)
            } 
        }
    }

}

