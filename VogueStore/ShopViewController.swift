//
//  ShopViewController.swift
//  VogueStore
//
//  Created by Portia Sharma on 9/28/16.
//  Copyright © 2016 Portia Sharma. All rights reserved.
//

import UIKit

class ShopViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var shopProductData = productData()
    var cartItemCount = 0

    @IBOutlet weak var productCollectionView: UICollectionView!
    
    //ShopVC as collectionView datasource & delegate
    //collectionViewCell from ProductView.xib
    //navBar textAttributes
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        
        self.productCollectionView.registerNib(UINib(nibName: "ProductView", bundle: nil), forCellWithReuseIdentifier: "productReuseCell")
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "HelveticaNeue-Light", size: 20)!, NSForegroundColorAttributeName: UIColor.darkGrayColor()]
        
        navigationItem.leftBarButtonItem?.image = UIImage(named: "backArrow")
        navigationItem.rightBarButtonItem?.image = UIImage(named: "Cart")


        
    }
    
    //addToCart
    @IBAction func addFeaturedItemButtonPressed(sender: UIButton) {
        incrementCartCounter()
    }
    
    //clear cart
    @IBAction func backButtonPressed(sender: UIBarButtonItem) {
        if cartItemCount > 1 {
            self.navigationController?.navigationBar.viewWithTag(cartItemCount)?.removeFromSuperview()
        }
        cartItemCount = 0
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    //MARK : - CollectionView datasource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("productReuseCell", forIndexPath: indexPath) as! ProductCollectionViewCell
        cell.productNameLabel.text = shopProductData.getProductData()[indexPath.row].name
        cell.productPriceLabel.text = shopProductData.getProductData()[indexPath.row].price
        cell.productImageView.image = shopProductData.getProductData()[indexPath.row].image
        cell.addToCartButton.tag = indexPath.row
        cell.addToCartButton.addTarget(self, action: "incrementCartCounter", forControlEvents: UIControlEvents.TouchUpInside)
        
        return cell
    }
    
    //collectionViewCell Layout
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsZero
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left + flowLayout.sectionInset.right + flowLayout.minimumInteritemSpacing
        let size = (collectionView.bounds.width - totalSpace)/2
        print("total space = ", totalSpace, size, 1.16 * size, collectionView.bounds.width)
        
        if collectionView.bounds.width < 340 {
            return CGSize(width: size, height: 1.5 * size)
        }
        return CGSize(width: size, height: 1.16 * size)
    }
    
    //Cart Counter & Badge
    func incrementCartCounter() {
        
        cartItemCount = cartItemCount + 1
        let navbar = navigationController?.navigationBar
        let navframe = CGRect(x: navbar!.frame.width - 30, y: 0, width: navbar!.frame.width/2, height: navbar!.frame.height)
        let navLabel = UILabel(frame: navframe)
        navLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 12.0)
        navLabel.text = "  \(cartItemCount)  "
        navLabel.sizeToFit()
        navLabel.textColor = UIColor.whiteColor()
        navLabel.backgroundColor = UIColor.redColor()
        navLabel.layer.cornerRadius = navLabel.frame.height/2
        navLabel.layer.masksToBounds = true
        navLabel.layer.borderColor = UIColor.darkGrayColor().CGColor
        navLabel.tag = cartItemCount
        navbar?.addSubview(navLabel)
        if cartItemCount > 1 {
            navbar?.viewWithTag(cartItemCount - 1)?.removeFromSuperview()
        }
    }
    
    //resize collectionviewCell for different screen sizes
    func calcCollectionViewCellSize() -> (x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
        //let screenHeight = UIScreen.mainScreen().bounds.height
        let screenWidth = UIScreen.mainScreen().bounds.width
        let x = CGFloat(25)
        let y = CGFloat(-50)
        let width = screenWidth - 50
        let height = screenWidth * (325 / 325)
        return (x,y,width,height)
    }

}
