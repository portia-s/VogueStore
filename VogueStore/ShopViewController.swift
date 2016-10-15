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
        
        self.productCollectionView.register(UINib(nibName: "ProductView", bundle: nil), forCellWithReuseIdentifier: "productReuseCell")
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "HelveticaNeue-Light", size: 20)!, NSForegroundColorAttributeName: UIColor.darkGray]
        
        navigationItem.leftBarButtonItem?.image = UIImage(named: "backArrow")
        navigationItem.rightBarButtonItem?.image = UIImage(named: "Cart")
        
    }
    
    //addToCart
    @IBAction func addFeaturedItemButtonPressed(_ sender: UIButton) {
        incrementCartCounter()
    }
    
    //clear cart
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        if cartItemCount >= 1 {
            self.navigationController?.navigationBar.viewWithTag(cartItemCount)?.removeFromSuperview()
            cartItemCount = 0
        }
        
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    //MARK : - CollectionView datasource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productReuseCell", for: indexPath) as! ProductCollectionViewCell
        cell.productNameLabel.text = shopProductData.getProductData()[(indexPath as NSIndexPath).row].name
        cell.productPriceLabel.text = shopProductData.getProductData()[(indexPath as NSIndexPath).row].price
        cell.productImageView.image = shopProductData.getProductData()[(indexPath as NSIndexPath).row].image
        cell.addToCartButton.tag = (indexPath as NSIndexPath).row
        cell.addToCartButton.addTarget(self, action: #selector(ShopViewController.incrementCartCounter), for: UIControlEvents.touchUpInside)
        
        return cell
    }
    
    //collectionViewCell Layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
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
        navLabel.textColor = UIColor.white
        navLabel.backgroundColor = UIColor.red
        navLabel.layer.cornerRadius = navLabel.frame.height/2
        navLabel.layer.masksToBounds = true
        navLabel.layer.borderColor = UIColor.darkGray.cgColor
        navLabel.tag = cartItemCount
        navbar?.addSubview(navLabel)
        if cartItemCount > 1 {
            navbar?.viewWithTag(cartItemCount - 1)?.removeFromSuperview()
        }
    }
    
    //resize collectionviewCell for different screen sizes
    func calcCollectionViewCellSize() -> (x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
        //let screenHeight = UIScreen.mainScreen().bounds.height
        let screenWidth = UIScreen.main.bounds.width
        let x = CGFloat(25)
        let y = CGFloat(-50)
        let width = screenWidth - 50
        let height = screenWidth * (325 / 325)
        return (x,y,width,height)
    }

}
