//
//  SignInManager.swift
//  SignUp&ImageCache
//
//  Created by fyz on 7/25/22.
//

import FirebaseAuth
import Firebase
import FirebaseFirestore
import FBSDKLoginKit

protocol SignInManagerProtocol{
    func createUser(firstName: String?, lastName: String?, email: String?, password: String?, completion:@escaping (Result<Void, Error>) -> Void)
    func signInUser(email: String?, password: String?, completion:@escaping (Result<Void, Error>) -> Void)
    func signInWithFB(token: String, completion:@escaping (Result<Void, Error>) -> Void)
    func signOut(completion:@escaping (Result<Void, Error>) -> Void)
}

class SignInManager: SignInManagerProtocol {
    
    //let dbManager = DBManager()
    let keychainManager = KeychainManager.standard
    
    func createUser(firstName: String?, lastName: String?, email: String?, password: String?, completion:@escaping (Result<Void, Error>) -> Void) {
        let firstName = firstName!.trimmingCharacters(in: .whitespacesAndNewlines)
        let lastName = lastName!.trimmingCharacters(in: .whitespacesAndNewlines)
        let email = email!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = password!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if firstName == "" ||
            lastName == "" ||
            email == "" ||
            password == "" {
            completion(.failure(FieldError.signUpError))
        } else {
            Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
                if let error = error {
                    completion(.failure(error))
                } else {
//                    let userId = result?.user.uid ?? ""
//                    self?.dbManager.saveUser(UserId: userId, firstName: firstName, lastName: lastName, email: email, password: password)
                    self?.saveKeychain(service: "firebase.google.com", account: email, password: password)
                    let password = self?.getKeychain(service: "firebase.google.com", account: email)
                    print(password as Any)
                    completion(.success(()))
                }
            }
        }
       
    }
    func signInUser(email: String?, password: String?, completion:@escaping (Result<Void, Error>) -> Void){
        let email = email!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = password!.trimmingCharacters(in: .whitespacesAndNewlines)
        if email == "" ||
            password == "" {
            completion(.failure(FieldError.signInError))
        } else {
            Auth.auth().signIn(withEmail: email, password: password) {[weak self] result, error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    self?.saveKeychain(service: "firebase.google.com", account: email, password: password)
                    let password = self?.getKeychain(service: "firebase.google.com", account: email)
                    print(password as Any)
                    //let userId = result?.user.uid ?? ""
                    //self?.dbManager.saveUser(UserId: userId, firstName: nil, lastName: nil, email: email, password: password)
                    completion(.success(()))
                }
            }
        }
    }
    
    func signInWithFB(token: String, completion:@escaping (Result<Void, Error>) -> Void) {
        let credential = FacebookAuthProvider.credential(withAccessToken: token)
        Auth.auth().signIn(with: credential){result, error in
            if let error = error {
                completion(.failure(error))
            } else {
                //let userId = result?.user.uid ?? ""
                //let email = result?.user.email ?? ""
                //self.dbManager.saveUser(UserId: userId, firstName: nil, lastName: nil, email: email, password: nil)
                completion(.success(()))
            }
        }
    }
    
    func signOut(completion:@escaping (Result<Void, Error>) -> Void){
        //let userId = Auth.auth().currentUser?.uid
        FBSDKLoginKit.LoginManager().logOut()
        do {
            deleteKeychain(service: "firebase.google.com", account: Auth.auth().currentUser!.email!)
            try Auth.auth().signOut()
            //self.dbManager.deleteUser(userId: userId)
            completion(.success(()))
        }
        catch let error as NSError {
            completion(.failure(error))
        }
    }
    // Save, get and delete from keychain
    func saveKeychain(service:String, account: String, password: String){
        do{
            try keychainManager.save(service: service,
                                     account: account,
                                     password: password.data(using: .utf8) ?? Data() )
        } catch {
            print(error)
        }
    }
    func getKeychain(service: String, account: String) -> String? {
        guard let result = keychainManager.get(service: service, account: account) else {
            print("Failed to read password")
            return nil
        }
        let password = String(decoding: result, as: UTF8.self)
        return password
    }
    func deleteKeychain(service: String, account: String){
        keychainManager.delete(service: service, account: account)
    }
}

extension FieldError: LocalizedError {
    public var errorDescription: String?{
        switch self {
        case .signUpError:
            return "Please fill all the fields"
        case .signInError:
            return "Please fill email and password"
        }
    }
}
