//
//  SpotifyImage.swift
//  RelayMusicPlayer
//
//  Created by Christian Kraft on 12/10/17.
//  Copyright © 2017 Christian Kraft. All rights reserved.
//

import Foundation

class SpotifyImage: Codable {
    // The image height in pixels. If unknown: null or not returned
    var height: Int
    // The source URL of the image
    var url: String
    // The image width in pixels. If unknown: null or not returned
    var width: Int
    
    init(height: Int, url: String, width: Int) {
        self.height = height
        self.url = url
        self.width = width
    }
}
