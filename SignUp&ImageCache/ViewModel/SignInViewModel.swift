//
//  FirebaseFunctions.swift
//  SignUp&ImageCache
//
//  Created by fyz on 6/15/22.
//

enum FieldError: Error {
    case signUpError
    case signInError
}

class SignInViewModel {
   
    // private let signInManager = SignInManager()
    private let signInManager: SignInManagerProtocol
   
    init(signInManager: SignInManagerProtocol = SignInManager()){
        self.signInManager = signInManager
    }
  
    //Sign Up
    func signUp(firstName: String?, lastName: String?, email: String?, password: String?, completion:@escaping (_ error: Error?) -> Void){
        signInManager.createUser(firstName: firstName, lastName: lastName, email: email, password: password) { result in
            switch result{
            case.success:
                completion(nil)
            case let .failure(error):
                completion(error)
            }
        }
    }
    
    //Sign In
    func signIn(email: String?, password: String?, completion:@escaping (_ error: Error?) -> Void) {
        signInManager.signInUser(email: email, password: password) { result in
            switch result{
            case.success:
                completion(nil)
            case let .failure(error):
                completion(error)
            }
        }
    }
    
    //Sign-In Facebook
    func fBSignIn(token: String, completion:@escaping (_ error: Error?) -> Void) {
        signInManager.signInWithFB(token: token) { result in
            switch result{
            case.success:
                completion(nil)
            case let .failure(error):
                completion(error)
            }
        }
    }
    
    //Sign Out
    func signOut(completion:@escaping (_ error: Error?) -> Void){
        signInManager.signOut { result in
            switch result{
            case.success:
                completion(nil)
            case let .failure(error):
                completion(error)
            }
        }
    }
    
}
