//
//  MusicPlayerHandler.swift
//  RelayMusicPlayer
//
//  Created by Christian Kraft on 9/13/17.
//  Copyright © 2017 Christian Kraft. All rights reserved.
//

import Foundation

struct MusicPlayerHandler {
    
    var player: MusicPlayer
    
    init(using player: MusicPlayer) {
        self.player = player
    }
    
    func play(){
        player.play()
    }
    func pause(){
        player.pause()
    }
    func next() {
        player.next()
    }
    func previous() {
        player.previous()
    }
    
}
