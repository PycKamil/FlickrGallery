//
//  ViewController+Banner.swift
//  FlickrGallery
//
//  Created by Kamil Pyc on 15/10/2017.
//  Copyright © 2017 Kamil Pyc. All rights reserved.
//

import UIKit
import NotificationBannerSwift

extension UIViewController {

    func showErrorBanner(_ title: String, message: String) {
        let banner = NotificationBanner(title: title, subtitle: message, style: .info)
        banner.show()
    }
}
