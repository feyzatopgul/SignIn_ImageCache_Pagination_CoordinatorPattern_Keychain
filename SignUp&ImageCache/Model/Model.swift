 //
//  Model.swift
//  SignUp&ImageCache
//
//  Created by fyz on 6/16/22.
//

import Foundation

struct APIResponse: Codable, Hashable {
    var results: [Model]
}
struct Model: Codable, Hashable {
    var id: String
    var description: String?
    var urls: ModelUrl
    
    func hash(into hasher: inout Hasher) {
            hasher.combine(self.id)
    }
    static func == (lhs: Model, rhs: Model) -> Bool {
            return lhs.id == rhs.id
    }
}
struct ModelUrl: Codable, Hashable {
    var thumb: String
}
