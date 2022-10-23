//
//  SignUp_ImageCacheUITests.swift
//  SignUp&ImageCacheUITests
//
//  Created by fyz on 7/22/22.
//

import XCTest

class SignUp_ImageCacheUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testExample() throws {
        let app = XCUIApplication()
                app.launch()
        
        let emailTextField = app.textFields["Email"]
                XCTAssertTrue(emailTextField.exists)
        emailTextField.tap()
        emailTextField.typeText("fyz@fyz.com")
        
        let passwordTextField = app.textFields["Password"]
        XCTAssertTrue(passwordTextField.exists)
        passwordTextField.tap()
        passwordTextField.typeText("fyz1234")
        
        let signInButton = app.buttons["Sign In"]
        XCTAssertTrue(signInButton.exists)
        signInButton.tap()
        
        let table = app.tables
        table.children(matching: .cell).element(boundBy: 1).swipeUp()
        table.children(matching: .cell).element(boundBy: 2).swipeDown()
        
        let signOutButton = app.navigationBars["SignUp_ImageCache.HomeView"].buttons["Sign out"]
        XCTAssertTrue(signOutButton.exists)
        signOutButton.tap()
        
        let continueFBButton = app.buttons["Continue with Facebook"]
        XCTAssertTrue(continueFBButton.exists)
        continueFBButton.tap()
        
        let alert = app.alerts["“SignUp&ImageCache” Wants to Use “facebook.com” to Sign In"]
        XCTAssertTrue(alert.exists)
        
        let cancelAlert = alert.scrollViews.buttons["Cancel"]
        XCTAssertTrue(cancelAlert.exists)
        
        let continueAlert = alert.scrollViews.buttons["Continue"]
        XCTAssertTrue(continueAlert.exists)
        continueAlert.tap()
        
        let continueButton = app.webViews.buttons["Continue"]
        XCTAssertTrue(continueButton.exists)
        continueButton.tap()
        
        signOutButton.tap()
        
        let createAccountButton = app.buttons["Create Account"]
        XCTAssertTrue(createAccountButton.exists)
        createAccountButton.tap()
        
        let firstNameTextField = app.textFields["First Name"]
        XCTAssertTrue(firstNameTextField.exists)
        firstNameTextField.tap()
        firstNameTextField.typeText("ayse")
        
        let lastNameTextField = app.textFields["Last Name"]
        XCTAssertTrue(lastNameTextField.exists)
        lastNameTextField.tap()
        lastNameTextField.typeText("aa")
        
        let emailTextField2 = app.textFields["Email"]
        XCTAssertTrue(emailTextField2.exists)
        emailTextField2.tap()
        emailTextField2.typeText("ayse@aa.com")
        
        let passwordTextField2 = app.textFields["Password"]
        XCTAssertTrue(passwordTextField2.exists)
        passwordTextField2.tap()
        passwordTextField2.typeText("ayse1234")
        
        signOutButton.tap()
        
        createAccountButton.tap()
        
        let alreadySignedInButton = app.buttons["Already Signed In?"]
        XCTAssertTrue(alreadySignedInButton.exists)
        alreadySignedInButton.tap()
        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
