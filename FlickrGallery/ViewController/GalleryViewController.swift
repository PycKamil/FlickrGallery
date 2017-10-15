//
//  GalleryViewController.swift
//  FlickrGallery
//
//  Created by Kamil Pyc on 14/10/2017.
//  Copyright © 2017 Kamil Pyc. All rights reserved.
//

import UIKit
import INSPhotoGallery

class GalleryViewController: UICollectionViewController {
    var photos: [INSPhoto] = [] {
        didSet {
            self.collectionView?.reloadData()
        }
    }

    lazy var dataFetcher = DataFetcher()
    override func viewDidLoad() {
        super.viewDidLoad()
        dataFetcher.fetchPhotosPublic { [weak self] result in
            switch result {
            case .success(let photos):
                self?.photos = photos
            case .failure:
                self?.showErrorBanner("Fetch photo", message: "Error occured while downloading data")
            }
        }
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.photoCollectionViewCell,
                                                      for: indexPath)!
        cell.populateWithPhoto(photos[indexPath.row])
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        let currentPhoto = photos[indexPath.row]
        let galleryPreview = INSPhotosViewController(photos: photos, initialPhoto: currentPhoto, referenceView: cell)
        present(galleryPreview, animated: true, completion: nil)
    }
}

extension GalleryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width)
        let height = 0.5 * width
        return CGSize(width: width, height: height)
    }
}
