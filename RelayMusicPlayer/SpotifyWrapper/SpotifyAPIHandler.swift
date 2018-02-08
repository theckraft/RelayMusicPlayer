//
//  APIHandler.swift
//  RelayMusicPlayer
//
//  Created by Christian Kraft on 9/28/17.
//  Copyright © 2017 Christian Kraft. All rights reserved.
//

import Foundation

class SpotifyAPIHandler {
    
    var session:SPTSession!
    
    //init, requires app-persistent spotify session
    public init(using session: SPTSession) {
        self.session = session
    }
    
    //generic request, takes a pre-generated url and a callback function
    //returns Data response
    //NEEDS MORE MODIFICATION/TRIMMING
    func request(with url: URL, onSuccess: @escaping (Data) -> Void, onFailure: @escaping () -> Void) {
        var request = URLRequest(url: url)
        request.addValue("Bearer \(session.accessToken!)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            guard let data = data, error == nil else {
                print("error=\(String(describing: error))")
                onFailure()
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
                onFailure()
                return
            }
            onSuccess(data)
        })
        task.resume()
    }
}

