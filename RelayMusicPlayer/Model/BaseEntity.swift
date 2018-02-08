//
//  BaseEntity.swift
//  RelayMusicPlayer
//
//  Created by Christian Kraft on 11/9/17.
//  Copyright © 2017 Christian Kraft. All rights reserved.
//

import Foundation

class BaseEntity: Codable {
    
    var id: Int
    
    init() {
        self.id = 0
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
    }
}
