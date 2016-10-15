//
//  ViewController.swift
//  VogueStore
//
//  Created by Portia Sharma on 9/27/16.
//  Copyright © 2016 Portia Sharma. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    var overlayView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    //create overlay and go for touchID
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        _ = performSegue(withIdentifier: "touchedToStore", sender: nil)
        /*
        overlayView = createOverlay()
        overlayView.tag = 001
        self.view.addSubview(overlayView)
        if isTouchIdAvailable() {
            loginWithTouchId()
        }*/
    }
    
    //prompt overlay
    func createOverlay() -> UIView {
        
        //create transparencyView for the screen
        let myView = UIView()
        myView.frame = self.view.bounds
        
        //calculate coordinates for prompt imageView
        let myX = Int((self.view.bounds.width - 262)/2)
        let myY = Int(self.view.bounds.height - 313 - 30)
        
        //create prompt imageView
        let myPrompt = UIImageView()
        myPrompt.frame = CGRect(x: myX, y: myY, width: 262, height: 313)
        myPrompt.image = UIImage(named: "screen2TouchIdPrompt")
        //myPrompt.tag = 001
        myView.addSubview(myPrompt)
        
        return myView
    }
    
    //check if touchId is supported
    func isTouchIdAvailable() -> Bool {
        
        let myContext = LAContext()
        var myError: NSError?
        
        let foundTouchID = myContext.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &myError)
        
        if foundTouchID == false {
            let myAlertController = UIAlertController(title: "Touch ID", message: "Not Available", preferredStyle: UIAlertControllerStyle.alert)
            myAlertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            present(myAlertController, animated: true, completion: nil)
        }
        return foundTouchID
        
    }
    
    //login with touchId or restart
    func loginWithTouchId() {
        
        let context  = LAContext()
        let reason = "Authenticate with TouchID"
        
        context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { (valid: Bool, error) in
            if valid {
                //segue to next screen
                _ = self.performSegue(withIdentifier: "touchedToStore", sender: nil)
            }
            else {
                //go back to login screen aka startover
                DispatchQueue.main.async(execute: { 
                     self.view.viewWithTag(001)?.removeFromSuperview()
                })
               
            }
        }
    }
    
}
