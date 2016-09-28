//
//  StoreViewController.swift
//  VogueStore
//
//  Created by Portia Sharma on 9/27/16.
//  Copyright © 2016 Portia Sharma. All rights reserved.
//

import UIKit

class StoreViewController: UIViewController {

    
    @IBOutlet weak var storeButton: UIButton!
    @IBOutlet weak var eventButton: UIButton!
    @IBOutlet weak var shopperButton: UIButton!
    @IBOutlet weak var offersButton: UIButton!
    @IBOutlet weak var loyaltyButton: UIButton!
    @IBOutlet weak var pageImageView: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addImageOnButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func addImageOnButton() {
    
       
    
    }
    
    @IBAction func storeButtonPressed(sender: UIButton) {
    }
    
    
    
    
}
