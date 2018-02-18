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
    
    public enum StatusCode: Int {
        case OK = 200,
        Created = 201,
        Accepted = 202,
        NoContent = 204,
        NotModified = 304,
        BadRequest = 400,
        Unauthorized = 401,
        Forbidden = 403,
        NotFound = 404,
        TooManyRequests = 429,
        InternalServerError = 500,
        BadGateway = 502,
        ServiceUnavailable = 503
    }
    
    //generic request, takes a pre-generated url and a callback function
    //returns Data response
    //NEEDS MORE MODIFICATION/TRIMMING
    func request(with url: URL, method: String = "GET", data: [String: String] = [:], onSuccess: @escaping ((Data,StatusCode)) -> Void, onFailure: @escaping (String) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = method
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            onFailure("Error: \(error.localizedDescription)")
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(session.accessToken!)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            guard let data = data, error == nil else {
                onFailure("Error: \(String(describing: error?.localizedDescription))")
                return
            }
            guard let httpStatus = response as? HTTPURLResponse, let statusCode = StatusCode(rawValue: httpStatus.statusCode) else {
                onFailure("Unidentified Error. Please Try Again Later.")
                return
            }
            switch statusCode {
            case .BadRequest, .Unauthorized, .Forbidden, .NotFound, .TooManyRequests, .InternalServerError, .BadGateway, .ServiceUnavailable:
                let jsonDecoder = JSONDecoder()
                do {
                    let error = try jsonDecoder.decode(SpotifyError.self, from:data)
                    onFailure(error.message)
                } catch {
                    onFailure("Unidentified Spotify Error with Code: \(statusCode.rawValue)")
                }
                break
            default:
                onSuccess((data, statusCode))
                break
            }
        })
        task.resume()
    }
}

