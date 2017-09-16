//
//  MusicPlayerViewController.swift
//  RelayMusicPlayer
//
//  Created by Christian Kraft on 9/12/17.
//  Copyright © 2017 Christian Kraft. All rights reserved.
//

import UIKit
import MediaPlayer

class MusicPlayerViewController: UIViewController, SPTAudioStreamingPlaybackDelegate, SPTAudioStreamingDelegate {
    
    var auth = SPTAuth.defaultInstance()!
    var session:SPTSession!
    var player2: SPTAudioStreamingController?
    var loginUrl: URL?
    
    func setup() {
        SPTAuth.defaultInstance().clientID = "6fad851d5d914cba8841f53f3fd7a56e"
        SPTAuth.defaultInstance().redirectURL = URL(string: "relaymusicplayer://redirect")
        SPTAuth.defaultInstance().requestedScopes = [SPTAuthStreamingScope, SPTAuthPlaylistReadPrivateScope, SPTAuthPlaylistModifyPublicScope, SPTAuthPlaylistModifyPrivateScope]
        loginUrl = SPTAuth.defaultInstance().spotifyAppAuthenticationURL()
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        UIApplication.shared.open(loginUrl!, options: [:], completionHandler: {
            (success) in
            print("Open \(String(describing: self.loginUrl)): \(success)")
            if self.auth.canHandle(self.auth.redirectURL) {
                print("here");
            }
        })
    }
    
    
    
    
    var player = ApplicationMusicPlayer(using: MPMusicPlayerApplicationController())
    
    
    @IBAction func playButtonPressed(_ sender: Any) {
        MPMediaLibrary.requestAuthorization { (status) in
            if status == .authorized {
                self.player.play()
            }
        }
    }
    @IBOutlet weak var loginButton: UIButton!
    
    @IBAction func pauseButtonPressed(_ sender: Any) {
        player.pause()
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        player.next()
    }
    
    @IBAction func previousButtonPressed(_ sender: Any) {
        player.previous()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        NotificationCenter.default.addObserver(self, selector: #selector(MusicPlayerViewController.updateAfterFirstLogin), name: NSNotification.Name(rawValue: "loginSuccessfull"), object: nil)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func updateAfterFirstLogin () {
        loginButton.isHidden = true
        let userDefaults = UserDefaults.standard
        
        if let sessionObj:AnyObject = userDefaults.object(forKey: "SpotifySession") as AnyObject? {
            
            let sessionDataObj = sessionObj as! Data
            let firstTimeSession = NSKeyedUnarchiver.unarchiveObject(with: sessionDataObj) as! SPTSession
            
            self.session = firstTimeSession
            initializePlayer(authSession: session)
            self.loginButton.isHidden = true
            // self.loadingLabel.isHidden = false
            
        }
    }
    
    func initializePlayer(authSession:SPTSession){
        if self.player2 == nil {
            self.player2 = SPTAudioStreamingController.sharedInstance()
            self.player2!.playbackDelegate = self
            self.player2!.delegate = self
            try! player2!.start(withClientId: auth.clientID)
            self.player2!.login(withAccessToken: authSession.accessToken)
        }
    }
    
    func audioStreamingDidLogin(_ audioStreaming: SPTAudioStreamingController!) {
        // after a user authenticates a session, the SPTAudioStreamingController is then initialized and this method called
        print("logged in")
        
        self.player2?.playSpotifyURI("spotify:track:58s6EuEYJdlb0kO7awm3Vp", startingWith: 0, startingWithPosition: 0, callback: { (error) in
            if (error != nil) {
                print("playing!")
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
