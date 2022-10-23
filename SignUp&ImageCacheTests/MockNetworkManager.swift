//
//  MockNetworkManager.swift
//  SignUp&ImageCacheTests
//
//  Created by fyz on 7/25/22.
//
@testable import SignUp_ImageCache
import Foundation

final class MockNetworkManager: NetworkManagerProtocol {
    
    let model1 = Model(id: "fk4tiMlDFF0",
                       description: "Lionheart",
                       urls: ModelUrl(thumb: "https://images.unsplash.com/photo-1546527868-ccb7ee7dfa6a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzMzg1NjZ8MHwxfHNlYXJjaHwxfHxwdXBweXxlbnwwfHx8fDE2NTg3ODQ2Mjc&ixlib=rb-1.2.1&q=80&w=200") )
    let model2 = Model(id: "5yAhL8ViUVg",
                       description: nil,
                       urls: ModelUrl(thumb: "https://images.unsplash.com/photo-1601979031925-424e53b6caaa?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzMzg1NjZ8MHwxfHNlYXJjaHwyfHxwdXBweXxlbnwwfHx8fDE2NTg3ODQ2Mjc&ixlib=rb-1.2.1&q=80&w=200"))
    
    
    func fetchData(page: Int, completion: @escaping ([Model]?, Error?) -> Void) {
        let result: [Model]? = [model1, model2]
        if let result = result {
            completion(result, nil)
        } else {
            completion(nil, MockNetworkError.badData)
        }
       
    }
    
    func fetchImage(model: Model, completion: @escaping (Data?, Error?) -> Void) {
        let data = Data()
        if model.urls.thumb == "https://images.unsplash.com/photo-1546527868-ccb7ee7dfa6a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzMzg1NjZ8MHwxfHNlYXJjaHwxfHxwdXBweXxlbnwwfHx8fDE2NTg3ODQ2Mjc&ixlib=rb-1.2.1&q=80&w=200" {
            completion(data, nil)
        } else {
            completion(nil, MockNetworkError.badData)
        }
    }
    
}

enum MockNetworkError: Error {
    case badResponse
    case badData
}

extension MockNetworkError: LocalizedError {
    public var errorDescription: String?{
        switch self {
        case .badResponse:
            return "badResponse"
        case.badData:
            return "badData"
            
        }
    }
}
