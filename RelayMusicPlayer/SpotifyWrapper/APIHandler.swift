//
//  APIHandler.swift
//  RelayMusicPlayer
//
//  Created by Christian Kraft on 9/28/17.
//  Copyright © 2017 Christian Kraft. All rights reserved.
//

import Foundation

class APIHandler {
    
    var session:SPTSession!
    
    init(_ session: SPTSession) {
        self.session = session
    }
    
    func request(with url: URL, callback: @escaping (Dictionary<String,Any>) -> Void) {
        var request = URLRequest(url: url)
        request.addValue("Bearer \(session.accessToken!)", forHTTPHeaderField: "Authorization")
        print("headers", request.allHTTPHeaderFields!)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            if let error = error {
                print(error)
                return
            }
            
            // Parse JSON data
            if let data = data {
                callback(self.parseJsonData(data: data))
                
                // Reload table view
                //                OperationQueue.main.addOperation({
                //                    self.tableView.reloadData()
                //                })
            }
        })
        task.resume()
    }
    
    func parseJsonData(data: Data) -> Dictionary<String,Any> {
        print("data", data)
        do {
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? Dictionary<String, AnyObject>
            return jsonResult!
            
            // Parse JSON data
            //            let jsonLoans = jsonResult?["loans"] as! [AnyObject]
            //            for jsonLoan in jsonLoans {
            //                let loan = Loan()
            //                loan.name = jsonLoan["name"] as! String
            //                loan.amount = jsonLoan["loan_amount"] as! Int
            //                loan.use = jsonLoan["use"] as! String
            //                let location = jsonLoan["location"] as! [String:AnyObject]
            //                loan.country = location["country"] as! String
            //                loans.append(loan)
            //            }
            
        } catch {
            print(error)
            return [String: String]()
        }
    }
    
}
