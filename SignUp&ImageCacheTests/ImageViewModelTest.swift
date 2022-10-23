//
//  ImageViewModelTest.swift
//  SignUp&ImageCacheTests
//
//  Created by fyz on 7/25/22.
//

import XCTest
@testable import SignUp_ImageCache

class ImageViewModelTest: XCTestCase {

    var imageViewModel: ImageViewModel!
    var mockNetworkManager: MockNetworkManager!
    
    override func setUpWithError() throws {
        mockNetworkManager = MockNetworkManager()
        imageViewModel = .init(networkManager: mockNetworkManager)
    }

    override func tearDownWithError() throws {
        imageViewModel = nil
        mockNetworkManager = nil
    }
    
    func testFetchData() throws {
        imageViewModel.modelData(page: 1) { results, error  in
            XCTAssertEqual(results![0].id, "fk4tiMlDFF0")
            XCTAssertEqual(results![0].description, "Lionheart")
            XCTAssertEqual(results![0].urls.thumb, "https://images.unsplash.com/photo-1546527868-ccb7ee7dfa6a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzMzg1NjZ8MHwxfHNlYXJjaHwxfHxwdXBweXxlbnwwfHx8fDE2NTg3ODQ2Mjc&ixlib=rb-1.2.1&q=80&w=200")
            //XCTAssertEqual(results![1].description, "cute puppy")
            XCTAssertNil(error, "can not fetch data")
        }
    }
    
    func testFetchImage() throws {
        imageViewModel.imageData(model: mockNetworkManager.model1) { imageData, error  in
            XCTAssertNil(error, error!.localizedDescription)
            
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
