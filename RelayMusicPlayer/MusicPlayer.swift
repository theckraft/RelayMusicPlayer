//
//  MusicPlayer.swift
//  RelayMusicPlayer
//
//  Created by Christian Kraft on 9/12/17.
//  Copyright © 2017 Christian Kraft. All rights reserved.
//

import Foundation
import MediaPlayer

protocol MusicPlayer {
    var player: MPMusicPlayerController { get set }
    
    init(using mpController: MPMusicPlayerController)
    
    func play()
    func pause()
    func next()
    func previous()
    
}
