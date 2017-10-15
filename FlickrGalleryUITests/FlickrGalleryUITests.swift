//
//  FlickrGalleryUITests.swift
//  FlickrGalleryUITests
//
//  Created by Kamil Pyc on 14/10/2017.
//  Copyright © 2017 Kamil Pyc. All rights reserved.
//

import XCTest

class FlickrGalleryUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        app = nil
        super.tearDown()
    }

    func testOpeningPhotoAndClosingWithSwipeUp() {
        app.selectPhoto()
        app.swipePhotoUp()
    }

    func testOpeningItemAndClosingWithButton() {
        app.selectPhoto()
        app.tapOnPhoto()
        app.closePhoto()
    }

}

extension XCUIApplication {
    fileprivate func selectPhoto() {
        collectionViews.element.tap()
    }

    fileprivate func swipePhotoUp() {
        images.firstMatch.swipeUp()
    }

    fileprivate func tapOnPhoto() {
        windows.firstMatch.tap()
    }

    fileprivate func closePhoto() {
        buttons["INSPhotoGalleryClose"].tap()
    }
}
