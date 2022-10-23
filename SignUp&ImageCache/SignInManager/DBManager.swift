//
//  DBManager.swift
//  SignUp&ImageCache
//
//  Created by fyz on 7/25/22.
//

import RealmSwift

class DBManager {
    
    private let realm = try! Realm()
    
    func saveUser(UserId: String, firstName: String?, lastName: String?, email: String, password: String?){
        let user = User()
        user.id = UserId
        if let firstName = firstName {
            user.firstName = firstName
        }
        if let lastName = lastName {
            user.lastName = lastName
        }
        user.email = email
        if let password = password {
            user.password = password
        }
        
        try! self.realm.write{
            self.realm.add(user)
        }
    }
    
    func deleteUser(userId: String?){
        let user = realm.object(ofType: User.self, forPrimaryKey: userId)
        try! realm.write{
            if let user = user {
                realm.delete(user)
            }
        }
    }
}
