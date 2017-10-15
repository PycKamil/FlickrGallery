//
//  FlickrGalleryTests.swift
//  FlickrGalleryTests
//
//  Created by Kamil Pyc on 14/10/2017.
//  Copyright © 2017 Kamil Pyc. All rights reserved.
//

import XCTest
import OHHTTPStubs
@testable import FlickrGallery

class DataFetcherTests: XCTestCase {
    var dataFetcher: DataFetcher!
    override func setUp() {
        super.setUp()
        self.dataFetcher = DataFetcher()
    }

    override func tearDown() {
        self.dataFetcher = nil
        OHHTTPStubs.removeAllStubs()
        super.tearDown()
    }

    func testFetchPhotosPublic_shouldReturnProperNumberOfPhotos_WhenRequestReturnProperData() {
        stub(condition: isHost("api.flickr.com")) { _ in
            let stubPath = OHPathForFile("PhotosPublic.json", type(of: self))
            return fixture(filePath: stubPath!, headers: ["Content-Type": "application/json"])
        }
        let fetchExpectation = expectation(description: "calls the callback with a resource object")

        dataFetcher.fetchPhotosPublic { result in
            switch result {
            case .success(let photos):
                XCTAssertEqual(photos.count, 20)
            case .failure:
                XCTFail("Request should end with success")
            }
            fetchExpectation.fulfill()
        }
        waitForExpectations(timeout: 1.0, handler: .none)
    }

    func testFetchPhotosPublic_shouldReturnInvalidJsonError_WhenReuqestReturnWrongJson() {
        stub(condition: isHost("api.flickr.com")) { _ in
            return OHHTTPStubsResponse(
                jsonObject: ["key": "value"],
                statusCode: 200,
                headers: [ "Content-Type": "application/json" ]
            )
        }
        let fetchExpectation = expectation(description: "calls the callback with a resource object")

        dataFetcher.fetchPhotosPublic { result in
            switch result {
            case .failure(.invalidJson):
                break
            default:
                XCTFail("Request should end with invalid json error")
            }
            fetchExpectation.fulfill()
        }
        waitForExpectations(timeout: 1.0, handler: .none)
    }

    func testFetchPhotosPublic_shouldReturnNetworkError_WhenReuqestFails() {
        stub(condition: isHost("api.flickr.com")) { _ in
            let error = NSError(
                domain: "test",
                code: 42,
                userInfo: [:]
            )
            return OHHTTPStubsResponse(error: error)
        }
        let fetchExpectation = expectation(description: "calls the callback with a resource object")

        dataFetcher.fetchPhotosPublic { result in
            switch result {
            case .failure(.network):
                break
            default:
                XCTFail("Request should end with invalid json error")
            }
            fetchExpectation.fulfill()
        }
        waitForExpectations(timeout: 1.0, handler: .none)
    }

    func testFetchPhotosPublic_shouldReturnInvalidJsonError_WhenReuqestReturnWrongData() {
        stub(condition: isHost("api.flickr.com")) { _ in
            return OHHTTPStubsResponse(
                data: Data(base64Encoded: "test")!,
                statusCode: 200,
                headers: [ "Content-Type": "application/json" ]
            )
        }
        let fetchExpectation = expectation(description: "calls the callback with a resource object")

        dataFetcher.fetchPhotosPublic { result in
            switch result {
            case .failure(.invalidJson):
                break
            default:
                XCTFail("Request should end with invalid data error")
            }
            fetchExpectation.fulfill()
        }
        waitForExpectations(timeout: 1.0, handler: .none)
    }
}
