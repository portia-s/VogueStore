//
//  StoreViewModel.swift
//  VogueStore
//
//  Created by Portia Sharma on 10/4/16.
//  Copyright © 2016 Portia Sharma. All rights reserved.
//

import Foundation

protocol StoreViewModelDelegate: class {
    
    func updateLoyaltyPoints(rewardPts: String)
}

class StoreViewModel: NSObject, URLSessionDelegate {
    
    weak var delegate: StoreViewModelDelegate?
    
    //get loyalty points w/ given API
    func getLoyaltyPoints() {
        
        //configure session
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 15.0
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        
        //call API
        let url = URL(string: "http://54.191.35.66:8181/pfchang/api/buy?username=Michael&grandTotal=0")
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = "POST"
        
        //get Data from server
        let task =  session.dataTask(with: request as URLRequest) {(data, response, error) in
            if error != nil {
                print("error: \(error!.localizedDescription)")
            }
            else if data != nil {
                //Parse JSON dictionary
                let rewardPts = self.jsonParsing(data!)
                DispatchQueue.main.async(execute: {
                    self.delegate?.updateLoyaltyPoints(rewardPts: rewardPts)
                    //self.loyaltyPointsLabel.text = rewardPts
                })
            }
        }
        task.resume()
    }

    //parse loyalty points data
    func jsonParsing(_ data: Data) -> String {
        var resultString = ""
        do {
            let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            print(jsonDictionary)
            let results = jsonDictionary as! NSDictionary
            let resultValue = results["rewardPoints"]
            resultString = "\(resultValue!)"
        }
        catch {
            print("CatchError: )")
        }
        return resultString
    }

    
    
}
