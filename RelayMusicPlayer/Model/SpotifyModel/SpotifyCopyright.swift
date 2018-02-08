//
//  SpotifyCopyright.swift
//  RelayMusicPlayer
//
//  Created by Christian Kraft on 12/10/17.
//  Copyright © 2017 Christian Kraft. All rights reserved.
//

import Foundation

class SpotifyCopyright: Codable {
    // The copyright text for this album
    var text: String
    // The type of copyright: C = the copyright, P = the sound recording (performance) copyright
    var type: String
    
    init(text: String, type: String) {
        self.text = text
        self.type = type
    }
}
