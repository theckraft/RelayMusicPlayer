//
//  ApplicationMusicPlayer.swift
//  RelayMusicPlayer
//
//  Created by Christian Kraft on 9/13/17.
//  Copyright © 2017 Christian Kraft. All rights reserved.
//

import Foundation

import MediaPlayer

struct ApplicationMusicPlayer: MusicPlayer {
    
    var player: MPMusicPlayerController
    
    init(using mpController: MPMusicPlayerController) {
        self.player = mpController
    }
    
    func play(){
        
        if player.playbackState == MPMusicPlaybackState.playing {
            player.pause()
            return
        }
        if player.playbackState == MPMusicPlaybackState.paused {
            player.play()
            return
        }
        
        let query = MPMediaQuery()
        
        let albumTitleFilter = MPMediaPropertyPredicate(value: "My Beautiful Dark Twisted Fantasy", forProperty: MPMediaItemPropertyAlbumTitle, comparisonType: MPMediaPredicateComparison.equalTo)
        query.addFilterPredicate(albumTitleFilter)
        player.setQueue(with: query)
        player.play()
    }
    
    func pause(){
        player.pause()
    }
    
    func next() {
        player.skipToNextItem()
    }
    
    func previous() {
        player.skipToPreviousItem()
    }
    
}
