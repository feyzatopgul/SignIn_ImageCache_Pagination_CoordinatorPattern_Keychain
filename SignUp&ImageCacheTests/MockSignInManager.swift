//
//  MockSignInManager.swift
//  SignUp&ImageCacheTests
//
//  Created by fyz on 7/25/22.
//

@testable import SignUp_ImageCache
import Foundation

final class MockSignInManager: SignInManagerProtocol {
    
    func createUser(firstName: String?, lastName: String?, email: String?, password: String?, completion: @escaping (Result<Void, Error>) -> Void) {
        let firstName = firstName!.trimmingCharacters(in: .whitespacesAndNewlines)
        let lastName = lastName!.trimmingCharacters(in: .whitespacesAndNewlines)
        let email = email!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = password!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if firstName == "" ||
            lastName == "" ||
            email == "" ||
            password == "" {
            completion(.failure(MockSignInError.fillError))
        } else {
            completion(.success(()))
        }
    }
    
    func signInUser(email: String?, password: String?, completion: @escaping (Result<Void, Error>) -> Void) {
        if let count = password?.count {
            if count < 8 {
                completion(.failure(MockSignInError.passwordShortError))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func signInWithFB(token: String, completion: @escaping (Result<Void, Error>) -> Void) {
        completion(.success(()))
    }
    
    func signOut(completion: @escaping (Result<Void, Error>) -> Void) {
        completion(.success(()))
    }
    
}

enum MockSignInError: Error {
    case fillError
    case passwordShortError
}

extension MockSignInError: LocalizedError {
    public var errorDescription: String?{
        switch self {
        case .fillError:
            return "Please fill all the fields"
        case .passwordShortError:
            return "Password must be at least 8 characters long"
        }
    }
}

