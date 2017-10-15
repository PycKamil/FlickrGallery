//
//  GalleryViewControllerTests.swift
//  FlickrGalleryTests
//
//  Created by Kamil Pyc on 15/10/2017.
//  Copyright © 2017 Kamil Pyc. All rights reserved.
//

import XCTest
import FBSnapshotTestCase
import INSPhotoGallery
@testable import FlickrGallery

class GalleryViewControllerTests: FBSnapshotTestCase {

    var galleryViewController: GalleryViewController!
    override func setUp() {
        super.setUp()
        self.recordMode = false
        galleryViewController = R.storyboard.main.instantiateInitialViewController()
    }

    func testGalleryViewControllerSnapshot() {
        galleryViewController.view.frame = CGRect(origin: .zero, size: CGSize(width: 300, height: 300))
        galleryViewController.photos = samplePhotos

        //Assert
        FBSnapshotVerifyView(galleryViewController.view)
    }

    func testGalleryViewController_numberOfCells_shouldEqualNumberOfPhotos() {
        // Arrange
        galleryViewController.photos = samplePhotos
        let testCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

        //Act
        let numberOfCells = galleryViewController.collectionView(testCollectionView, numberOfItemsInSection: 0)

        //Assert
        XCTAssertEqual(numberOfCells, samplePhotos.count)
    }

    // MARK: Helpers
    fileprivate lazy var samplePhotos: [INSPhoto] = {
        let bundle = Bundle.init(for: GalleryViewControllerTests.self)
        let sampleImage1 = UIImage(named: "sample.jpg", in: bundle, compatibleWith: nil)
        let photo1 = INSPhoto(image: sampleImage1, thumbnailImage: sampleImage1)
        let sampleImage2 = UIImage(named: "sample2.jpg", in: bundle, compatibleWith: nil)
        let photo2 = INSPhoto(image: sampleImage2, thumbnailImage: sampleImage2)
        return [photo1, photo2]
    }()

}
