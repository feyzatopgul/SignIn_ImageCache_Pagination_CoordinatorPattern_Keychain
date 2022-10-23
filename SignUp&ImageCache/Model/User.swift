//
//  User.swift
//  SignUp&ImageCache
//
//  Created by fyz on 6/21/22.
//

import Foundation
import RealmSwift

class User: Object {
    @Persisted(primaryKey: true) var id: String = ""
    @Persisted var firstName: String = ""
    @Persisted dynamic var lastName: String = ""
    @Persisted dynamic var email: String = ""
    @Persisted dynamic var password: String = ""
    
}
