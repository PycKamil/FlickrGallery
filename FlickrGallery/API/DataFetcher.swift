//
//  DataFetcher.swift
//  FlickrGallery
//
//  Created by Kamil Pyc on 15/10/2017.
//  Copyright © 2017 Kamil Pyc. All rights reserved.
//

import Foundation
import Result
import Unbox
import INSPhotoGallery

enum FetchError: Error {
    case invalidData
    case invalidJson
    case network
}

final class DataFetcher {

    func test() {
        NSLog("Test")
    }
    
    func fetchPhotosPublic(completion: @escaping (Result<[INSPhoto], FetchError>) -> Void) {
        flickrProvider.request(.photosPublic) { result in
            switch result {
            case .success(let response):
                do {
                    guard let json = try response.mapJSON() as? UnboxableDictionary else {
                        completion(.failure(.invalidData))
                        return
                    }
                    let photosPublic: PhotosPublic = try unbox(dictionary: json)
                    let photos = photosPublic.items.map {
                        return INSPhoto(imageURL: $0.media.m, thumbnailImageURL: $0.media.m)
                    }
                    completion(.success(photos))
                } catch {
                    completion(.failure(.invalidJson))
                }
            case .failure:
                completion(.failure(.network))
            }
        }
    }
}
