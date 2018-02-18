//
//  SpotifyCategoriesComposite.swift
//  RelayMusicPlayer
//
//  Created by Christian Kraft on 2/8/18.
//  Copyright © 2018 Christian Kraft. All rights reserved.
//

import Foundation

struct SpotifyCategoriesComposite: Decodable {
    
    let categories: SpotifyPaging<SpotifyCategory>
    
    enum AlbumsKey: CodingKey {
        case categories
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AlbumsKey.self)
        self.categories = try container.decode(SpotifyPaging<SpotifyCategory>.self, forKey: .categories)
    }
    
}
