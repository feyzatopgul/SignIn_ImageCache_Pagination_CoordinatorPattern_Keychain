//
//  SignInViewModelTest.swift
//  SignUp&ImageCacheTests
//
//  Created by fyz on 7/25/22.
//

import XCTest
@testable import SignUp_ImageCache

class SignInViewModelTest: XCTestCase {
    
    var signInViewModel: SignInViewModel!
    var mockSignInManager: MockSignInManager!
    
    override func setUpWithError() throws {
        mockSignInManager = MockSignInManager()
        signInViewModel = .init(signInManager: mockSignInManager)
    }

    override func tearDownWithError() throws {
        signInViewModel = nil
        mockSignInManager = nil
    }
    func testSignUpSuccess() throws {
        signInViewModel.signUp(firstName: "Feyza", lastName: "Topgul", email: "fyz@fyz.com", password: "fyz1234") { error in
            XCTAssertNil(error, "Can not sign up")
        }
    }
    
    func testSignInSuccess() throws {
        signInViewModel.signIn(email: "fyz@fyz.com", password: "fyz123456") { error in
            XCTAssertNil(error, error!.localizedDescription)
        }
    }
    func testSignOutSuccess() throws {
        signInViewModel.signOut { error in
            XCTAssertNil(error, "Can not sign out")
        }
    }
    func testFBSignInSuccess() throws {
        signInViewModel.fBSignIn(token: "123764787hdhs934jsbdh") { error in
            XCTAssertNil(error)
        }
    }
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}


