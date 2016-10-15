//
//  StoreViewController.swift
//  VogueStore
//
//  Created by Portia Sharma on 9/27/16.
//  Copyright © 2016 Portia Sharma. All rights reserved.
//
import Foundation
import UIKit



class StoreViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate, StoreViewModelDelegate {

    var pageViewController = UIPageViewController()
    var images = ["screen3shoes","screen4heels","screen5events","screen6shopper"]
    
    var currentPage: Int = 0 {
        didSet {
            DispatchQueue.main.async { 
                self.selectedPageControl(self.currentPage)
            }
        }
    }
    
    var myStoreViewModel = StoreViewModel()

    @IBOutlet weak var storeButton: UIButton!
    @IBOutlet weak var eventButton: UIButton!
    @IBOutlet weak var shopperButton: UIButton!
    @IBOutlet weak var offersButton: UIButton!
    @IBOutlet weak var loyaltyButton: UIButton!
    @IBOutlet weak var loyaltyPointsLabel: UILabel!
    @IBOutlet weak var pageImageView: UIImageView!
    @IBOutlet weak var pagecontrol1: UIImageView!
    @IBOutlet weak var pagecontrol2: UIImageView!
    @IBOutlet weak var pagecontrol3: UIImageView!
    @IBOutlet weak var pagecontrol4: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    //set navTitle, pageView, PVController, get loyaltyPoints
    override func viewDidLoad() {
        super.viewDidLoad()
        myStoreViewModel.delegate = self

        navigationItem.titleView = UIImageView(image: UIImage(named: "NavTitle"))
        navigationItem.leftBarButtonItem?.image = UIImage(named: "MenuBarButton")
        navigationItem.rightBarButtonItem?.image = UIImage(named: "UserBarButton")
        
        self.pageViewController = UIPageViewController(transitionStyle: UIPageViewControllerTransitionStyle.scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.horizontal, options: nil)
        self.pageViewController.delegate = self
        self.pageViewController.dataSource = self
        let pageFrame = calcPageViewSize()
        pageViewController.view.frame = CGRect(x: pageFrame.x , y: pageFrame.y, width: pageFrame.width , height: pageFrame.height)//screenWidth * (244/325))//pageImageView.bounds
        self.addChildViewController(pageViewController)
        pageViewController.setViewControllers([vcAtIndex(0)], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
        selectedPageControl(0)
        self.view.addSubview(pageViewController.view)
        
        myStoreViewModel.getLoyaltyPoints()
    }
    
    @IBAction func storeButtonPressed(_ sender: UIButton) {
    }
    
    func updateLoyaltyPoints(rewardPts: String) {
        self.loyaltyPointsLabel.text = rewardPts
    }
    
    
    //MARK : - PageViewController
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = Int(viewController.restorationIdentifier!) {
            currentPage = index
            if index > 0 {
                return vcAtIndex(index - 1)
            } else {
                return vcAtIndex(images.count - 1)
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = Int(viewController.restorationIdentifier!) {
            currentPage = index
            if index < images.count - 1 {
                return vcAtIndex(index + 1)
            }
            else {
                return vcAtIndex(0)
            }
        }
        return nil
    }
    
    func vcAtIndex(_ index: Int) -> UIViewController {
        let vc = UIViewController()
        let pageFrame = calcPageViewSize()
        vc.view.frame = CGRect(x: pageFrame.x , y: pageFrame.y, width: pageFrame.width , height: pageFrame.height)
        let vcImageView = UIImageView()
        vcImageView.image = UIImage(named:images[index])
        vcImageView.frame = vc.view.bounds
        print(vc.view.bounds)
        vcImageView.contentMode = UIViewContentMode.scaleAspectFit
        vc.view.addSubview(vcImageView)
        vc.restorationIdentifier = String(index)
        return vc
    }
    
    //pagecontrol selection
    func selectedPageControl(_ index: Int) {
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
    
    //resize pageview for different screen sizes
    func calcPageViewSize() -> (x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
        //let screenHeight = UIScreen.mainScreen().bounds.height
        let screenWidth = UIScreen.main.bounds.width
        let x = CGFloat(25)
        let y = CGFloat(-50)
        let width = screenWidth - 50
        var height: CGFloat
        if screenWidth < 340 {
            height = screenWidth * (300 / 325)
        } else {
            height = screenWidth * (325 / 325)
        }
        return (x,y,width,height)
    }
    
    
}

