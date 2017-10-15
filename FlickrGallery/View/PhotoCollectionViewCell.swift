//
//  PhotoCollectionViewCell.swift
//  FlickrGallery
//
//  Created by Kamil Pyc on 14/10/2017.
//  Copyright © 2017 Kamil Pyc. All rights reserved.
//

import UIKit
import INSPhotoGallery

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    func populateWithPhoto(_ photo: INSPhotoViewable) {
        photo.loadThumbnailImageWithCompletionHandler { [weak photo, imageView] (image, _) in
            guard let image = image else { return }
            if let photo = photo as? INSPhoto {
                photo.thumbnailImage = image
            }
            imageView?.image = image
        }
    }
}
