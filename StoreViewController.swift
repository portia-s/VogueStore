//
//  StoreViewController.swift
//  VogueStore
//
//  Created by Portia Sharma on 9/27/16.
//  Copyright © 2016 Portia Sharma. All rights reserved.
//

import UIKit

class StoreViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    var pageViewController = UIPageViewController()
    var images = ["screen3shoes","screen4heels","screen5events","screen6shopper"]
    var currentPageIndex = 0
    
    @IBOutlet weak var storeButton: UIButton!
    @IBOutlet weak var eventButton: UIButton!
    @IBOutlet weak var shopperButton: UIButton!
    @IBOutlet weak var offersButton: UIButton!
    @IBOutlet weak var loyaltyButton: UIButton!
    @IBOutlet weak var pageImageView: UIImageView!
    @IBOutlet weak var pagecontrol1: UIImageView!
    @IBOutlet weak var pagecontrol2: UIImageView!
    @IBOutlet weak var pagecontrol3: UIImageView!
    @IBOutlet weak var pagecontrol4: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.pageViewController = UIPageViewController(transitionStyle: UIPageViewControllerTransitionStyle.Scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.Horizontal, options: nil)
        self.pageViewController.delegate = self
        self.pageViewController.dataSource = self
        let screenHeight = UIScreen.mainScreen().bounds.height - 280 - 30
        let screenWidth = UIScreen.mainScreen().bounds.width
        let viewWidth = screenHeight * (325/2444)
        //        vc.view.frame = CGRect(x: (screenWidth - viewWidth)/2, y: 0, width: screenHeight * (325/244) , height: screenHeight
            pageViewController.view.frame = CGRect(x: (screenWidth - viewWidth)/2, y: 20, width: viewWidth, height: screenHeight)//screenWidth * (244/325))//pageImageView.bounds
        self.addChildViewController(pageViewController)
        
        pageViewController.setViewControllers([vcAtIndex(0)], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        selectedPageControl(0)
        self.view.addSubview(pageViewController.view)

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

    
    @IBAction func storeButtonPressed(sender: UIButton) {
        //performSegueWithIdentifier("", sender: nil)
    }
    
//    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
//        print(previousViewControllers[0].restorationIdentifier)
//        selectedPageControl(Int(previousViewControllers[0].restorationIdentifier!)!)
//    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        if let index = Int(viewController.restorationIdentifier!) {
            print("Index Before ",index)
            if index > 0 {
                currentPageIndex = index - 1
                selectedPageControl(index -  1)
                return vcAtIndex(index - 1)
            } else {
                currentPageIndex = images.count - 1
                selectedPageControl(images.count - 1)
                return vcAtIndex(images.count - 1)
            }
        }
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        if let index = Int(viewController.restorationIdentifier!) {
            print("Index After ",index)
            if index < images.count - 1 {
                currentPageIndex = index + 1
                selectedPageControl(index +  1)
                return vcAtIndex(index + 1)
            }
            else {
                currentPageIndex = 0
                selectedPageControl(0)
                return vcAtIndex(0)
            }
        }
        return nil
    }
    
    func vcAtIndex(index: Int) -> UIViewController {
        let vc = UIViewController()
        let screenHeight = UIScreen.mainScreen().bounds.height - 560 - 30
        let screenWidth = UIScreen.mainScreen().bounds.width
        let viewWidth = screenHeight * (325/2444)
        vc.view.frame = CGRect(x: (screenWidth - viewWidth)/2, y: 0, width: screenHeight * (325/244) , height: screenHeight)//screenWidth * (244/325))
        let vcImageView = UIImageView()
        vcImageView.image = UIImage(named:images[index])
        vcImageView.frame = vc.view.bounds
        print(vc.view.bounds)
        vcImageView.contentMode = UIViewContentMode.ScaleToFill
        vc.view.addSubview(vcImageView)
        vc.restorationIdentifier = String(index)
        return vc
    }
    
    func selectedPageControl(index: Int) {
        switch index {
        case 0 :
            self.pagecontrol1.image = UIImage(named:"PageSelected")
            self.pagecontrol2.image = UIImage(named:"PageUnselected")
            self.pagecontrol3.image = UIImage(named:"PageUnselected")
            self.pagecontrol4.image = UIImage(named:"PageUnselected")
        case 1 :
            self.pagecontrol1.image = UIImage(named:"PageUnselected")
            self.pagecontrol2.image = UIImage(named:"PageSelected")
            self.pagecontrol3.image = UIImage(named:"PageUnselected")
            self.pagecontrol4.image = UIImage(named:"PageUnselected")
        case 2 :
            self.pagecontrol1.image = UIImage(named:"PageUnselected")
            self.pagecontrol2.image = UIImage(named:"PageUnselected")
            self.pagecontrol3.image = UIImage(named:"PageSelected")
            self.pagecontrol4.image = UIImage(named:"PageUnselected")
        case 3 :
            self.pagecontrol1.image = UIImage(named:"PageUnselected")
            self.pagecontrol2.image = UIImage(named:"PageUnselected")
            self.pagecontrol3.image = UIImage(named:"PageUnselected")
            self.pagecontrol4.image = UIImage(named:"PageSelected")
        default:
            break
        }
    }
        
//    //pageControl
//    
//    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
//        return images.count
//    }
//    
//    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
//        return 0
//    }
    
}
