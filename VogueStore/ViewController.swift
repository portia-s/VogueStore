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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginButtonPressed(sender: UIButton) {
        
        //create overlay
        overlayView = createOverlay()
        self.view.addSubview(overlayView)
        if touchIdIsAvailable() {
            loginWithTouchId()
        }
        
    }

    
    func createOverlay() -> UIView {
        
        //create transparencyView for the screen
        let myView = UIView()
        myView.frame = self.view.bounds
        myView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.8)
        
        //calculate coordinates for prompt imageView
        let myX = Int((self.view.bounds.width - 262)/2)
        let myY = Int(self.view.bounds.height - 313 - 30)
        
        //create prompt imageView
        let myPrompt = UIImageView()
        myPrompt.frame = CGRect(x: myX, y: myY, width: 262, height: 313)
        myPrompt.image = UIImage(named: "screen2TouchIdPrompt")
        myView.addSubview(myPrompt)
        
        return myView
    }
    
    func touchIdIsAvailable() -> Bool {
        
        let myContext = LAContext()
        var myError: NSError?
        
        let isTouchIDAvailable = myContext.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &myError)
        
        //        if isTouchIDAvailable == false {
//            let myAlertController = UIAlertController(title: "Touch ID", message: "Not Available", preferredStyle: UIAlertControllerStyle.Alert)
//            myAlertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
//            presentViewController(myAlertController, animated: true, completion: nil)
        //        }
        return isTouchIDAvailable
        
    }
    
    func loginWithTouchId() {
        
        let context  = LAContext()
        var error: NSError?
        let reason = "Authenticate with TouchID"
        
        context.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { (valid: Bool, error) in
            if valid {
                //segue to next screen
            }
            else {
                //go back to login screenaka startover
            }
        }
    }
    
    
}
