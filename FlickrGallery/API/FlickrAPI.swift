//
//  FlickrAPI.swift
//  FlickrGallery
//
//  Created by Kamil Pyc on 14/10/2017.
//  Copyright © 2017 Kamil Pyc. All rights reserved.
//

import Foundation
import Moya

enum Flickr {
    case photosPublic
}

let flickrProvider = MoyaProvider<Flickr>()

extension Flickr: TargetType {
    var baseURL: URL { return URL(string: "https://api.flickr.com/services/feeds/")!}

    var path: String {
        switch self {
        case .photosPublic:
            return "photos_public.gne"
        }
    }

    var method: Moya.Method {
        return .get
    }

    // swiftlint:disable line_length
    var sampleData: Data {
        switch self {
        case .photosPublic:
            return """
                {
                    "title": "Uploads from everyone",
                    "link": "https://www.flickr.com/photos/",
                    "description": "",
                    "modified": "2017-10-14T08:38:04Z",
                    "generator": "https://www.flickr.com",
                    "items": [
                        {
                            "title": "IMG_4101",
                            "link": "https://www.flickr.com/photos/g_kuge/23833724478/",
                            "media": {
                                "m": "https://farm5.staticflickr.com/4469/23833724478_39ce409977_m.jpg"
                            },
                            "date_taken": "2014-09-22T18:28:20-08:00",
                            "description": " <p><a href=\"https://www.flickr.com/people/g_kuge/\">g_kuge</a> posted a photo:</p> <p><a href=\"https://www.flickr.com/photos/g_kuge/23833724478/\" title=\"IMG_4101\"><img src=\"https://farm5.staticflickr.com/4469/23833724478_39ce409977_m.jpg\" width=\"240\" height=\"180\" alt=\"IMG_4101\" /></a></p> ",
                            "published": "2017-10-14T08:38:04Z",
                            "author": "nobody@flickr.com (\"g_kuge\")",
                            "author_id": "106125342@N02",
                            "tags": ""
                        }
                    ]
                }
            """.data(using: String.Encoding.utf8)!
        }
    }

    var task: Task {
        switch self {
        case .photosPublic:
            return .requestParameters(parameters: ["format": "json", "nojsoncallback": "1"], encoding: URLEncoding.default)
        }
    }

    var headers: [String: String]? {
        return nil
    }

}
